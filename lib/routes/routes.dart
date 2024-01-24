import 'package:get/get.dart';
import 'package:practical_softieons/app_main.dart';

import '../admin_login/presentation/admin_login_screen.dart';
import '../admin_login/presentation/login_main.dart';
import '../admin_login/presentation/user_login_screen.dart';
import '../property/presentation/add_property_screen.dart';
import '../property/presentation/property_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const defaultDuration = Duration(milliseconds: 150);

  static const String mainScreen = '/mainScreen';
  static const String loginScreen = '/LoginScreen';
  static const String homeScreen = '/HomeScreen';
  static const String mainLoginScreen = '/MainLoginScreen';
  static const String adminLoginScreen = '/AdminLoginScreen';
  static const String addPropertyScreen = '/AddPropertyScreen';

  static List<GetPage<dynamic>> pages = [
   GetPage<dynamic>(
      name: mainScreen,
      page: () => const MainScreen(),
      transitionDuration: defaultDuration,
      transition: Transition.fadeIn,
    ),GetPage<dynamic>(
      name: loginScreen,
      page: () => LoginScreen(),
      transitionDuration: defaultDuration,
      transition: Transition.fadeIn,
    ),GetPage<dynamic>(
      name: mainLoginScreen,
      page: () => const MainLoginScreen(),
      transitionDuration: defaultDuration,
      transition: Transition.fadeIn,
    ),GetPage<dynamic>(
      name: adminLoginScreen,
      page: () =>  AdminLoginScreen(),
      transitionDuration: defaultDuration,
      transition: Transition.fadeIn,
    ),GetPage<dynamic>(
      name: addPropertyScreen,
      page: () =>  AddPropertyScreen(isAdmin: false.obs),
      transitionDuration: defaultDuration,
      transition: Transition.fadeIn,
    ),
  ];
}
