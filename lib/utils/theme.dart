import 'package:flutter/material.dart';
import 'app_string.dart';
import 'colors.dart';

ThemeData themeData = ThemeData(
  backgroundColor: AppColors.white,
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primary,
  canvasColor: AppColors.white,
  secondaryHeaderColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.primary,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.softGreen,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      shadowColor: MaterialStateProperty.all<Color>(
        Colors.transparent,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      shadowColor: MaterialStateProperty.all<Color>(
        Colors.transparent,
      ),
    ),
  ),
  dialogBackgroundColor: AppColors.white,
  errorColor: AppColors.red,
  platform: TargetPlatform.iOS,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  applyElevationOverlayColor: true,
  appBarTheme: AppBarTheme(
    elevation: 5,
    shadowColor: AppColors.primary.withAlpha(30),
    backgroundColor: AppColors.primary,
  ),
  fontFamily: AppString.defaultFont,
  splashFactory: NoSplash.splashFactory,
);
