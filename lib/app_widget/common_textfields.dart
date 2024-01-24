import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final Rx<TextEditingController> controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? minLine;
  final RxBool? suffixClear;
  final RxBool? enableBorder;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? errorMsg;
  final bool autoCorrect;
  final bool enableSuggestions;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final Widget? prefixIcon;
  final Color? enableBorderColor;
  final Function()? onTap;
  final String? hintText;
  final TextStyle? labelTextStyle;
  final TextStyle? style;
  final Widget? suffixIcon;
  final bool expands;
  final bool readOnly;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onEditingComplete;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.obscureText = false,
      this.validator,
      this.onChanged,
      this.textInputType,
      this.labelText,
      this.maxLine,
      this.minLine,
      this.suffixClear,
      this.textInputAction = TextInputAction.done,
      this.onFieldSubmitted,
      this.errorMsg,
      this.focusNode,
      this.enableBorder,
      this.autofocus = false,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.textCapitalization = TextCapitalization.none,
      this.prefixIcon,
      this.enableBorderColor,
      this.onTap,
      this.hintText,
      this.labelTextStyle,
      this.suffixIcon,
      this.style,
      this.expands = false,
      this.readOnly = false,
      this.onSaved,
      this.inputFormatters,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            autocorrect: autoCorrect,
            onSaved: onSaved,
            enableSuggestions: enableSuggestions,
            textCapitalization: textCapitalization,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            obscureText: obscureText,
            onChanged: onChanged,
            controller: controller.value,
            keyboardType: textInputType,
            maxLines: maxLine,
            minLines: minLine,
            textInputAction: TextInputAction.done,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                errorMaxLines: 2,
                hintText: hintText,
                errorStyle: const TextStyle(height: 1),
                contentPadding: EdgeInsets.all(13.w),
                label: Text(
                  labelText ?? '',
                  textAlign: TextAlign.start,
                  style: labelTextStyle ??
                      TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.lightTextColor,
                          fontWeight: FontWeight.w500),
                ),
                hintMaxLines: maxLine,
                hintTextDirection: TextDirection.ltr,
                hintStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                labelStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    borderSide: BorderSide(color: AppColors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    borderSide: BorderSide(
                        color: enableBorder != null
                            ? enableBorder!.isTrue
                                ? enableBorderColor ?? AppColors.black
                                : AppColors.transparent
                            : AppColors.transparent)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    borderSide: BorderSide(color: AppColors.black)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    borderSide: BorderSide(color: AppColors.redColor)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    borderSide: BorderSide(color: AppColors.black)),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                filled: true,
                focusColor: AppColors.primaryColor,
                fillColor: AppColors.white,
                hoverColor: AppColors.primaryColor),
            textAlignVertical: TextAlignVertical.top,
            expands: expands,
            style: style ??
                const TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none),
            cursorColor: AppColors.black,
            cursorWidth: 1,
            enabled: true,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: autofocus,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
          ),
        );
      },
    );
  }
}
