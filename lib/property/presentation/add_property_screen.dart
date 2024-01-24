import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:practical_softieons/property/widget/dialog.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/colors.dart';

import '../../admin_login/widget/common_login_widget.dart';
import '../../local_storage/user_database.dart';
import '../../utils/navigation.dart';
import '../controller/property_controller.dart';
import '../widget/property_widget.dart';

class AddPropertyScreen extends StatefulWidget {
  AddPropertyScreen({Key? key, required this.isAdmin}) : super(key: key);
  RxBool? isAdmin;

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final PropertyController propertyController = Get.find();

  final formKeyAddProperty = GlobalKey<FormState>();

  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var arg = Get.arguments;
    widget.isAdmin!.value = arg['isAdmin'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white.withOpacity(0.5),
        bottomNavigationBar: Obx(
          () => widget.isAdmin?.value == true
              ? const SizedBox()
              : CommonLoginWidget(
                  buttonText: AppString.addText,
                  onPressed: () async {
                    if (formKeyAddProperty.currentState!.validate()) {
                      await userRepository.addProperty(
                          propertyController.propertyNameController.value.text,
                          propertyController.image.value,
                          double.parse(propertyController
                              .propertyNormalPrice.value.text),
                          double.parse(propertyController
                              .propertyWeekendPrice.value.text),
                          int.parse(propertyController
                              .propertyCancellationChargeController
                              .value
                              .text));
                      propertyController.getAllProperties();
                      Navigation.pop();
                      // Navigation.pushNamed(Routes.propertyScreen);
                    }
                  },
                ).paddingOnly(bottom: 30.h, right: 10.w, left: 10.w),
        ),
        body: Obx(
          () => widget.isAdmin?.isTrue ?? false
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Obx(
                      () => Column(
                        children: [
                          Text(
                            AppString.propertyDetails,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600),
                          ).paddingOnly(bottom: 20.w),
                          CommonTextWidget(
                              title: AppString.propertyName,
                              value: propertyController
                                  .propertyNameController.value.text),
                          CommonTextWidget(
                              title:AppString.normalPrice,
                              value: propertyController
                                  .propertyNormalPrice.value.text),
                          CommonTextWidget(
                              title: AppString.weekendPrice,
                              value: propertyController
                                  .propertyWeekendPrice.value.text),
                          Text(
                            AppString.historyText,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600),
                          ).paddingOnly(bottom: 10.h, top: 30.h),
                          Column(
                            children: List.generate(
                                propertyController.bookingModel?.length ?? 0,
                                (index) {
                              propertyController.fetchUserName(
                                  propertyController
                                      .bookingModel?[index].userId);
                              return Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                  child: Column(
                                    children: [
                                      CommonTextWidget(
                                          title: AppString.propertyName,
                                          value: propertyController.name.value),
                                      CommonTextWidget(
                                          title: AppString.propertyStatus,
                                          value: propertyController
                                                      .bookingModel![index]
                                                      .status ==
                                                  1
                                              ? AppString.bookedText
                                              : AppString.cancelText.toString()),
                                      CommonTextWidget(
                                          title: AppString.propertyPrice,
                                          value: propertyController
                                              .bookingModel![index]
                                              .bookingPrice!
                                              .toStringAsFixed(2)
                                              .toString()),
                                      CommonTextWidget(
                                          title: AppString.propertyBookingDate,
                                          value: propertyController.dateFormat(
                                              DateTime.parse(propertyController
                                                      .bookingModel![index]
                                                      .bookingDate ??
                                                  ''))),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Form(
                  key: formKeyAddProperty,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Text(
                          AppString.addPropertyText,
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600),
                        ).paddingOnly(bottom: 20.w),
                        Container(
                          width: 300.w,
                          height: 170.h,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(20.w)),
                          child: GestureDetector(
                            onTap: () async {
                              CommonWidget.showCameraDialog(context,
                                  propertyController: propertyController);
                            },
                            child: Obx(
                              () => propertyController.image.value != ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Image.file(
                                        File(propertyController.image.value),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                          padding: EdgeInsets.all(30.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(300.w),
                                              color: AppColors.black
                                                  .withOpacity(0.3)),
                                          child: Icon(Icons.camera_alt_outlined,
                                              size: 40.w)),
                                    ),
                            ),
                          ),
                        ).paddingOnly(bottom: 30.w),
                        AddPropertyCommonWidget(
                          controller: propertyController.propertyNameController,
                          hintText: AppString.propertyLabelName,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.vPropertyName;
                            }
                            return null;
                          },
                          labelName: AppString.propertyLabelName,
                        ),
                        AddPropertyCommonWidget(
                          controller: propertyController.propertyNormalPrice,
                          hintText: AppString.propertyNP,
                          needKeyBoardNumber: true,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.normalPrice;
                            }
                            return null;
                          },
                          labelName: AppString.propertyNP,
                        ),
                        AddPropertyCommonWidget(
                          controller: propertyController.propertyWeekendPrice,
                          hintText: AppString.propertyWP,
                          needKeyBoardNumber: true,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.weekendPrice;
                            }
                            return null;
                          },
                          labelName: AppString.propertyWP,
                        ),
                        AddPropertyCommonWidget(
                            controller: propertyController
                                .propertyCancellationChargeController,
                            hintText: AppString.cancelChargeLabel,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return AppString.cancelCharge;
                              } else if (int.parse(val) > 100) {
                                return AppString.validPercentage;
                              }
                              return null;
                            },
                            needKeyBoardNumber: true,
                            labelName: AppString.cancelChargeLabel),
                        widget.isAdmin?.isTrue ?? false
                            ? Text(
                                'Status==>${propertyController.status}',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ).paddingOnly(bottom: 5.w)
                            : const SizedBox(),
                      ]),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
