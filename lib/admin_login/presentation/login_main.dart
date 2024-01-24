import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/admin_login/widget/common_login_widget.dart';
import 'package:practical_softieons/routes/routes.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/navigation.dart';

import '../../utils/colors.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.5),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CommonLoginWidget(
          buttonText: AppString.userLogin,
          onPressed: () {
            Navigation.pushNamed(Routes.loginScreen);
          },
        ).paddingOnly(bottom: 10.w),
        CommonLoginWidget(
            buttonText: AppString.adminLogin,
            onPressed: () {
              Navigation.pushNamed(Routes.adminLoginScreen);
            }),
      ]).paddingAll(10.w),
    );
  }
}
