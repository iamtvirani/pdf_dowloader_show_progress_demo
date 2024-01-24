import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practical_softieons/utils/app_string.dart';

import '../../utils/loader.dart';

class GoogleSignInAuth {
  static GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        "810835020035-aevb6osb8l489so3a94j1k6d6sts94h4.apps.googleusercontent.com",
    scopes: ['email'],
  );

  static Future<GoogleSignInAccount?> signInGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      googleSignIn.signOut();
      googleUser = await googleSignIn.signIn();
      Fluttertoast.showToast(msg: AppString.googleSuccess);
      return googleUser;
    } catch (e) {
      removeAppLoader();
      Fluttertoast.showToast(msg: AppString.googleFailed);
    }
    return null;
  }

  Future<void> googleLogOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
