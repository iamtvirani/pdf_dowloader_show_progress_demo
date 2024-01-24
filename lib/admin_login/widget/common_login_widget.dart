import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/app_widget/bouncing.dart';
import 'package:practical_softieons/utils/colors.dart';

class CommonLoginWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final String? image;

  const CommonLoginWidget(
      {Key? key, this.onPressed, required this.buttonText, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
        onPressed: onPressed,
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(300.w)
            ),
            height: 52.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image == null
                    ? const SizedBox()
                    : Image.asset(image ?? "", height: 30.h, width: 30.w)
                        .paddingOnly(right: 10.w),
                Text(
                  buttonText,
                  style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            )));
  }
}
