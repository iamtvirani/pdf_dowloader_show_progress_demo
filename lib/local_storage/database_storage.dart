import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../admin_login/model/user_model.dart';
import '../property/model/book_model.dart';
import '../property/model/property_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  //init database
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'main.db');
    return openDatabase(path, version: 1, onCreate: _createTables);
  }

  //get all properties
  Future<List<Property>> getAllProperties() async {
    final Database db = await database;
    final List<Map<String, dynamic>> propertyMaps =
        await db.query('properties');

    return propertyMaps.map((map) {
      return Property(
        id: map['id'],
        propertyName: map['property_name'],
        photos: map['photos'],
        normalPrice: map['normal_price'],
        weekendPrice: map['weekend_price'],
      );
    }).toList();
  }

  //user already exist
  Future<bool> doesUserExist(String userId) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    return results.isNotEmpty;
  }
//user exist
  Future<void> insertOrUpdateUser(UserData user) async {
    final Database db = await database;

    bool userExists = await doesUserExist(user.id ?? "");

    if (userExists) {
      await db.update(
        'users',
        user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } else {
      await db.insert(
        'users',
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  //get all booking data
  Future<List<BookingModel>> getAllBooking() async {
    final Database db = await database;
    final List<Map<String, dynamic>> bookingProperMap =
        await db.query('bookings');

    return bookingProperMap.map((map) {
      return BookingModel(
        id: map['id'],
        userId: map['user_id'],
        propertyId: map['property_id'],
        bookingDate: map['booking_date'],
        status: map['status'],
        bookingPrice: map['booking_price'],
      );
    }).toList();
  }

  //cancel booking with cancel charge
  Future<void> cancelBooking(int bookingId) async {
    final Database db = await database;
    List<Map<String, dynamic>> bookingResults = await db.query(
      'bookings',
      columns: ['property_id', 'booking_price'],
      where: 'id = ?',
      whereArgs: [bookingId],
    );

    if (bookingResults.isNotEmpty) {
      int propertyId = bookingResults[0]['property_id'];
      double originalBookingPrice = bookingResults[0]['booking_price'];
      List<Map<String, dynamic>> propertyResults = await db.query(
        'properties',
        columns: ['normal_price'],
        where: 'id = ?',
        whereArgs: [propertyId],
      );

      if (propertyResults.isNotEmpty) {
        double originalPropertyPrice = propertyResults[0]['normal_price'];
        double newBookingPrice =
            originalBookingPrice - (0.2 * originalPropertyPrice);
        await db.update(
          'bookings',
          {'status': 0, 'booking_price': newBookingPrice},
          where: 'id = ?',
          whereArgs: [bookingId],
        );

        Fluttertoast.showToast(
            msg: 'Booking canceled successfully with 20% charge deducted');
      } else {
        throw Exception('Property not found for property_id: $propertyId');
      }
    } else {
      throw Exception('Booking not found for id: $bookingId');
    }
  }

  //create database
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY,
      username TEXT,
      email TEXT,
      photoUrl TEXT,
      userId TEXT
      )
  ''');

    await db.execute('''
    CREATE TABLE properties(
      id INTEGER PRIMARY KEY,
      property_name TEXT,
      photos TEXT,
      normal_price REAL,
      weekend_price REAL,
      cancel_charger REAL
    )
  ''');

    await db.execute('''
      CREATE TABLE bookings(
        id INTEGER PRIMARY KEY,
        user_id INTEGER,
        property_id INTEGER,
        booking_date TEXT,
        status INTEGER,
        booking_price INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(property_id) REFERENCES properties(id)
      )
    ''');
  }
}
