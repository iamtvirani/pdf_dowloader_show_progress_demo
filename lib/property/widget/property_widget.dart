import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:practical_softieons/utils/colors.dart';

import '../../app_widget/common_textfields.dart';

class AddPropertyCommonWidget extends StatelessWidget {
  const AddPropertyCommonWidget(
      {Key? key,
      required this.controller,
      required this.labelName,
      this.validator,
      required this.hintText,
      this.needKeyBoardNumber = false})
      : super(key: key);
  final Rx<TextEditingController> controller;
  final String labelName;
  final String hintText;
  final bool needKeyBoardNumber;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelName,
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
        ).paddingOnly(bottom: 5.w),
        CustomTextFormField(
          textInputType:
              needKeyBoardNumber ? TextInputType.number : TextInputType.text,
          controller: controller,
          hintText: hintText,
          validator: validator,
        ).paddingOnly(bottom: 10.w),
      ],
    );
  }
}
class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget({Key? key, required this.title, required this.value}) : super(key: key);
final String title;
final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: TextStyle(color: AppColors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),),
        Text(value,style: TextStyle(color: AppColors.black,fontSize: 16.sp),),
      ],
    );
  }
}
