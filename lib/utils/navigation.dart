import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation {
  static dynamic push(Widget child) {
    return Get.to<dynamic>(child);
  }

  static void pushAnimation(
    BuildContext context,
    Route route,
  ) {
    Navigator.push(
      context,
      route,
    );
  }

  static void pushReplacement(
    BuildContext context,
    Route route,
  ) {
    Navigator.pushReplacement(
      context,
      route,
    );
  }

  static void pushNamed(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.toNamed<dynamic>(routeName, arguments: arg, parameters: params);
  }

  static void popAndPushNamed(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.offAndToNamed<dynamic>(routeName, arguments: arg, parameters: params);
  }

  static void leftToRight(Widget child) {
    Get.to<dynamic>(child, transition: Transition.leftToRight);
  }

  static void rightToLeft(Widget child) {
    Get.to<dynamic>(child, transition: Transition.rightToLeft);
  }

  static void replace(String routeName) {
    Get.offNamed<dynamic>(routeName);
  }

  static void pop({dynamic params = false}) {
    Get.back<dynamic>(result: params);
  }

  static void doublePop() {
    Get
      ..back<dynamic>()
      ..back<dynamic>();
  }

  static void removeAll(Widget child) {
    Get.offAll<dynamic>(child);
  }

  static void popupUtil(String routeName) {
    Get.offNamedUntil<dynamic>(routeName, (route) => false);
  }

  static void pushAndPopUntil(
    String pushName,
    String untilName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.offNamedUntil<dynamic>(
      pushName,
      (route) => route.settings.name == untilName,
      arguments: arg,
      parameters: params,
    );
  }

  static void replaceAll(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.offAllNamed(routeName, arguments: arg, parameters: params);
  }
}
