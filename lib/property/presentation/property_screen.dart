import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practical_softieons/local_storage/user_database.dart';
import 'package:practical_softieons/property/presentation/book_property.dart';
import 'package:practical_softieons/routes/routes.dart';
import 'package:practical_softieons/utils/app_string.dart';
import 'package:practical_softieons/utils/colors.dart';
import 'package:practical_softieons/utils/navigation.dart';
import 'package:practical_softieons/utils/shared_prefrences.dart';

import '../../admin_login/services/google_sign_in_service.dart';
import '../controller/property_controller.dart';
import '../widget/show_property_data.dart';

class PropertyScreen extends StatefulWidget {
  final bool? isUserLogin;

  const PropertyScreen({Key? key, required this.isUserLogin}) : super(key: key);

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final PropertyController propertyController = Get.put(PropertyController());
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white.withOpacity(0.5),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.isUserLogin == false
                    ? IconButton(
                        onPressed: () async {
                          await propertyController.clearData();
                          Navigation.pushNamed(Routes.addPropertyScreen,
                              arg: {'isAdmin': false});
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30.w,
                        ))
                    : SizedBox(),
                IconButton(
                    onPressed: () async {
                      await SharedPrefs.removeAllData();
                      await SharedPrefs.setIsAdmin(isAdmin: false);
                      await GoogleSignInAuth.googleSignIn.signOut();
                      Navigation.replaceAll(Routes.mainLoginScreen);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 30.w,
                    )),
              ],
            ),
            Expanded(
              child: Obx(
                () => propertyController.isDataLoad.isTrue
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : propertyController.properties.isEmpty
                        ? Center(
                            child: Text(
                                widget.isUserLogin == true
                                    ? AppString.noDataFound
                                    : AppString.plzTapToAddProperty,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp)),
                          )
                        : ListView.builder(
                            itemCount: propertyController.properties.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  var data =
                                      propertyController.properties[index];

                                  propertyController.bookModelList.isEmpty
                                      ? null
                                      : await propertyController
                                          .getPropertyData(data.id);
                                  await propertyController.setData(
                                      name: data.propertyName,
                                      normalPrice:
                                          data.normalPrice.toInt().toString(),
                                      imageValue: data.photos,
                                      weeklyPrice:
                                          data.weekendPrice.toInt().toString(),
                                      propertyStatus: 1.toString());
                                  widget.isUserLogin == true
                                      ? Get.to(
                                          () => BookProperty(property: data))
                                      : Navigation.pushNamed(
                                          Routes.addPropertyScreen,
                                          arg: {'isAdmin': true});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.w)),
                                  padding: EdgeInsets.all(10.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10.w)),
                                        child: Image.file(
                                          File(propertyController
                                              .properties[index].photos),
                                          fit: BoxFit.fill,
                                          width: 65.w,
                                          height: 65.w,
                                        ),
                                      ).paddingOnly(right: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShowPropertyData(
                                            propertyName:
                                                AppString.propertyName,
                                            propertySubTitle: propertyController
                                                .properties[index].propertyName,
                                          ),
                                          ShowPropertyData(
                                            propertyName: AppString.propertyNP,
                                            propertySubTitle: propertyController
                                                .properties[index].normalPrice
                                                .toInt()
                                                .toString(),
                                          ),
                                          ShowPropertyData(
                                            propertyName: AppString.propertyWP,
                                            propertySubTitle: propertyController
                                                .properties[index].weekendPrice
                                                .toInt()
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ).paddingAll(10.w),
                              );
                            }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
