import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/admin_login/widget/common_login_widget.dart';
import 'package:practical_softieons/property/presentation/property_screen.dart';
import 'package:practical_softieons/routes/routes.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/colors.dart';
import 'package:practical_softieons/utils/navigation.dart';

import '../../app_widget/common_textfields.dart';
import '../../utils/shared_prefrences.dart';
import '../controller/admin_controller.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({Key? key}) : super(key: key);
  final AdminController adminController = Get.put(AdminController());
  final formKeyAdminSignIn = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.5),
      body: Form(
        key: formKeyAdminSignIn,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onLongPress: () {
                  adminController.emailController.value.text =
                      'admin@gmail.com';
                  adminController.passwordController.value.text = 'admin@123';
                },
                child: Text(
                  AppString.email,
                  style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
                ),
              ).paddingOnly(bottom: 5.w),
              CustomTextFormField(
                controller: adminController.emailController,
                hintText: AppString.email,
                validator: (val) {
                  if (val!.isEmpty) {
                    return AppString.vEnterEmail;
                  } else if (val != 'admin@gmail.com') {
                    return AppString.vEnterVEmail;
                  }
                  return null;
                },
              ).paddingOnly(bottom: 10.w),
              Text(
                AppString.pwd,
                style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
              ).paddingOnly(bottom: 5.w),
              CustomTextFormField(
                controller: adminController.passwordController,
                hintText: AppString.pwd,
                validator: (val) {
                  if (val!.isEmpty) {
                    return AppString.vEnterPwd;
                  } else if (val != 'admin@123') {
                    return AppString.vEnterVPwd;
                  }
                  return null;
                },
              ).paddingOnly(bottom: 50.w),
              CommonLoginWidget(
                buttonText: 'Login',
                onPressed: () {
                  if (formKeyAdminSignIn.currentState!.validate()) {
                    SharedPrefs.setIsAdmin(isAdmin: true);
                    Navigation.push(PropertyScreen(isUserLogin: false));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
