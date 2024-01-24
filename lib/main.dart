import 'package:flutter/material.dart';
import 'package:practical_softieons/utils/shared_prefrences.dart';

import 'local_storage/database_storage.dart';
import 'app_main.dart';
import 'local_storage/user_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().initDatabase();
  await SharedPrefs.init();
  // UserRepository().deleteAllProperties();

  runApp(MainScreen());
}
