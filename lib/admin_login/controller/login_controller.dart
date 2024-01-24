import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practical_softieons/admin_login/model/user_model.dart';
import 'package:practical_softieons/property/presentation/property_screen.dart';
import 'package:practical_softieons/utils/shared_prefrences.dart';
import 'package:sqflite/sqflite.dart';

import '../../local_storage/database_storage.dart';
import '../../local_storage/user_database.dart';
import '../../routes/routes.dart';
import '../../utils/loader.dart';
import '../../utils/navigation.dart';
import '../services/google_sign_in_service.dart';

class LoginController extends GetxController {
  UserRepository userRepository = UserRepository();
  UserData userModel = UserData();
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> googleSignIn() async {
    try {
      appLoader(Get.context!);
      GoogleSignInAccount? user = await GoogleSignInAuth.signInGoogle();
      if (user != null) {
        userModel = UserData(
          id: user.id,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoUrl,
          serverAuthCode: user.serverAuthCode,
        );
        dbHelper.insertOrUpdateUser(userModel);
        SharedPrefs.saveUserData(jsonEncode(userModel));
        Navigation.removeAll(const PropertyScreen(isUserLogin: true));
      }
    } catch (e, st) {
      removeAppLoader();
    } finally {}
    return;
  }
}
