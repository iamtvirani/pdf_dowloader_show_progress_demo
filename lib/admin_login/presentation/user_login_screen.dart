import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/admin_login/widget/common_login_widget.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/colors.dart';

import '../../utils/assets.dart';
import '../controller/login_controller.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.5),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppString.login.toUpperCase(),
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w600)),
            CommonLoginWidget(
              buttonText: AppString.googleLogin,
              image: AppImagesAsset.googleImage,
              onPressed: () {
                loginController.googleSignIn();
              },
            ).paddingSymmetric(vertical: 10.w),
          ]).paddingAll(10.w),
    );
  }
}
