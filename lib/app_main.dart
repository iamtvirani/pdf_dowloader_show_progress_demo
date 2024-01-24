import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/admin_login/presentation/login_main.dart';
import 'package:practical_softieons/property/presentation/property_screen.dart';
import 'package:practical_softieons/utils/shared_prefrences.dart';

import 'routes/routes.dart';
import 'utils/keyboard.dart';
import 'utils/theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        initialBinding: AppBidding(),
        theme: themeData,
        builder: (context, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                KeyboardUtils.dismissKeyboard(context);
              },
              child: child,
            ),
          );
        },
        navigatorKey: Get.key,
        // initialRoute: Routes.mainLoginScreen,
        home: SharedPrefs.getIsAdmin() == true
            ? PropertyScreen(
                isUserLogin: SharedPrefs.getIsAdmin() == false ? true : false)
            : SharedPrefs.getUserData() == ""
                ? const MainLoginScreen()
                : PropertyScreen(
                    isUserLogin:
                        SharedPrefs.getIsAdmin() == false ? true : false),
        color: Colors.white,
        getPages: Routes.pages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {
  }
}
