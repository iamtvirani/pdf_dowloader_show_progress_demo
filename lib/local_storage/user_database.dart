import 'package:practical_softieons/admin_login/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_storage.dart';

class UserRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<int> addUser(
      String username, String email, String photoUrl, String userId) async {
    final Database db = await dbHelper.database;
    return await db.insert('users', {
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'userId': userId
    });
  }

  Future<int> addProperty(String propertyName, String photos,
      double normalPrice, double weekendPrice, int cancelCharge) async {
    print(
        'stored data==>$propertyName==>$photos==>$normalPrice==>$weekendPrice');
    final Database db = await dbHelper.database;
    return await db.insert('properties', {
      'property_name': propertyName,
      'photos': photos,
      'normal_price': normalPrice,
      'weekend_price': weekendPrice,
      'cancel_charger': cancelCharge
    });
  }

  Future<List<User>> getAllUsers() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> users = await db.query('users');
    return users.map((userMap) => User.fromJson(userMap)).toList();
  }

  Future<void> deleteAllProperties() async {
    final Database db = await dbHelper.database;
    await db.delete('users');
    await db.delete('bookings');
    await db.delete('properties');
  }

  Future<void> recordBooking(int userId, int propertyId, double propertyPrice,
      int status, String date) async {
    final Database db = await dbHelper.database;
    await db.insert('bookings', {
      'user_id': userId,
      'property_id': propertyId,
      'booking_date': date,
      'booking_price': propertyPrice,
      'status': status,
    });
  }

  Future<List<Map<String, dynamic>>> getPropertyById(int propertyId) async {
    final Database db = await dbHelper.database;
    List<Map<String, dynamic>> results = await db.query(
      'bookings',
      where: 'property_id = ?',
      whereArgs: [propertyId],
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      throw Exception('Property not found for id: $propertyId');
    }
  }

  Future<Map<String, dynamic>> getUserById(int userId) async {
    final Database db = await dbHelper.database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (results.isNotEmpty) {
      return results[0];
    } else {
      throw Exception('User not found for id: $userId');
    }
  }

  Future<String> fetchUserData(int userId) async {
    String? name;
    try {
      // Use the `getUserById` method to get user data
      Map<String, dynamic> userData = await getUserById(userId);

      // Now, you can use `userData` as needed
      print('User ID: ${userData['id']}');
      print('Username: ${userData['username']}');
      print('Email: ${userData['email']}');
      name = userData['username'];
      // Add more fields as needed
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return name ?? "";
  }

  Future<double> calculateBookingPrice(
      int userId, int propertyId, double propertyPrice,String type) async {
    final Database db = await dbHelper.database;
    int? bookingCount = Sqflite.firstIntValue(
      await db.rawQuery(
          'SELECT COUNT(*) FROM bookings WHERE user_id = ?', [userId]),
    );
    print('bookingCount==>$bookingCount');
    if (bookingCount == 0 || bookingCount == 1) {
      return 0.9 * await getPropertyPrice(propertyId,type);
    } else {
      return await getPropertyPrice(propertyId,type);
    }
  }

  Future<double> getPropertyPrice(int propertyId,String type) async {
    final Database db = await dbHelper.database;
    List<Map<String, dynamic>> results = await db.query('properties',
        columns: ['normal_price', 'weekend_price'],
        where: 'id = ?',
        whereArgs: [propertyId]);

    double normalPrice = results[0]['normal_price'];
    double weekendPrice = results[0]['weekend_price'];
    print('propertyPrice==>$normalPrice');

    return type=='weekend' ? weekendPrice : normalPrice;
  }
}
