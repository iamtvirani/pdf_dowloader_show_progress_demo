import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
    logAllData();
  }

  //? to print all the available data
  static void logAllData() {
    final keys = instance.getKeys();
    for (final key in keys) {
      log(
        "$key : ${instance.get(key)}",
        name: " :package: Storage :package: ",
      );
    }
  }

  static Future<void> saveUserData(String token) async {
    await instance.setString(AppConstant.userData, token);
  }

  static String userData = '';

  static String getUserData()  {
    userData = instance.getString(AppConstant.userData) ?? "";
    return userData;
  }

  static Future<bool> removeUserData() async {
    instance.remove(AppConstant.userData);
    return instance.clear();
  }

  static Future setIsAdmin({required bool? isAdmin}) async {
    await instance.setBool(AppConstant.isAdmin, isAdmin ?? false);
  }

  static bool? getIsAdmin() {
    return instance.getBool(AppConstant.isAdmin);
  }

  static Future<void> removeAllData()async {
    instance.clear();
  }
}
