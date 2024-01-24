import 'package:flutter/material.dart';

class KeyboardUtils {
  static void dismissKeyboard(BuildContext context) =>
      FocusManager.instance.primaryFocus?.unfocus();

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
