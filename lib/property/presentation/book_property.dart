import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:practical_softieons/admin_login/model/user_model.dart';
import 'package:practical_softieons/app_widget/common_textfields.dart';
import 'package:practical_softieons/local_storage/user_database.dart';
import 'package:practical_softieons/property/controller/property_controller.dart';
import 'package:practical_softieons/property/model/property_model.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/shared_prefrences.dart';
import 'package:sqflite/sqflite.dart';

import '../../admin_login/widget/common_login_widget.dart';
import '../../local_storage/database_storage.dart';
import '../../utils/colors.dart';
import '../../utils/navigation.dart';

class BookProperty extends StatefulWidget {
  BookProperty({Key? key, required this.property}) : super(key: key);
  final Property property;
  final PropertyController propertyController = Get.find();

  @override
  State<BookProperty> createState() => _BookPropertyState();
}

class _BookPropertyState extends State<BookProperty> {
  UserRepository userRepository = UserRepository();
  final DatabaseHelper dbHelper = DatabaseHelper();
  final PropertyController propertyController = Get.find();
  String? id;
  int? bookingId;
  String getUserData = SharedPrefs.getUserData();
  Map<String, dynamic>? storageUserData;
  final bookFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => getData());
  }

  //get current user id
  getData() async {
    storageUserData = jsonDecode(getUserData);
    propertyController.allUsers = await userRepository.getAllUsers();
    for (User user in propertyController.allUsers!) {
      if (user.userId == storageUserData?['id']) {
        id = user.id.toString();
      }
    }
    compareUserData();
  }
//check property is Booked or not
  compareUserData() async {
    await widget.propertyController.getAllBookingData();
    propertyController.alreadyBooked.value = false;
    for (var ele in propertyController.bookModelList) {
      if (ele.userId.toString() == id && widget.property.id == ele.propertyId) {
        bookingId = ele.id;
        propertyController.alreadyBooked.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text(
          widget.property.propertyName,
          style: TextStyle(color: AppColors.white),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        child: Obx(
          () => propertyController.alreadyBooked.isTrue
              ? CommonLoginWidget(
                      buttonText: AppString.cancelBooking,
                      onPressed: () async {
                        final DatabaseHelper dbHelper = DatabaseHelper();
                        dbHelper.cancelBooking(bookingId ?? 0);
                        Navigation.pop();
                      })
                  .paddingOnly(bottom: 30.h, right: 10.w, left: 10.w, top: 10.w)
              : CommonLoginWidget(
                      buttonText: AppString.bookNow,
                      onPressed: () async {
                        if (bookFormKey.currentState!.validate()) {
                          if (propertyController.bookModelList.isEmpty) {
                            await userRepository.recordBooking(
                                int.parse(id ?? ""),
                                widget.property.id,
                                await userRepository.calculateBookingPrice(
                                    int.parse(id ?? ""),
                                    widget.property.id,
                                    widget.property.normalPrice,
                                    propertyController.type.value),
                                1,
                                propertyController.propertyDate.value.text);
                            propertyController.getAllProperties();
                          } else {
                            for (var element
                                in propertyController.bookModelList) {
                              DateFormat propertyTime =
                                  DateFormat('yyyy-MM-dd');
                              String formattedDate = propertyTime.format(
                                  DateTime.parse(element.bookingDate ?? ""));
                              if (formattedDate.compareTo(propertyTime
                                          .format(DateTime.now())) ==
                                      0 &&
                                  element.propertyId == widget.property.id &&
                                  element.userId.toString() == id) {
                                propertyController.alreadyData.value = true;
                                Fluttertoast.showToast(
                                    msg: AppString.alreadyBooked);
                                return;
                              }
                            }
                            propertyController.alreadyData.isTrue
                                ? null
                                : await userRepository.recordBooking(
                                    int.parse(id ?? ""),
                                    widget.property.id,
                                    await userRepository.calculateBookingPrice(
                                        int.parse(id ?? ""),
                                        widget.property.id,
                                        widget.property.normalPrice,
                                        propertyController.type.value),
                                    1,
                                    propertyController.propertyDate.value.text);
                          }
                          Navigation.pop();
                        }
                      })
                  .paddingOnly(
                      bottom: 30.h, right: 10.w, left: 10.w, top: 10.w),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              File(widget.property.photos),
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              '${AppString.propertyName} ${widget.property.propertyName}',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ).paddingSymmetric(vertical: 10.w),
            Text(
              '${AppString.price} \$${widget.property.normalPrice}',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ).paddingSymmetric(vertical: 10.w),
            Text(
              '${AppString.weekPrice} \$${widget.property.weekendPrice}',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ).paddingSymmetric(vertical: 10.w),
            propertyController.alreadyBooked.isTrue
                ? const SizedBox()
                : Form(
                    key: bookFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.selectDate,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ).paddingOnly(bottom: 10.w, top: 5.w),
                        CustomTextFormField(
                          controller: propertyController.propertyDate,
                          enableBorderColor: AppColors.transparent,
                          readOnly: true,
                          suffixIcon: const Icon(Icons.calendar_month),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.vSelectDate;
                            }
                            return null;
                          },
                          onTap: () {
                            propertyController.selectDate(context);
                          },
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
