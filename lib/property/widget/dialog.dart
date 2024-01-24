import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:practical_softieons/property/controller/property_controller.dart';
import 'package:practical_softieons/utils/app_string.dart';

import '../../utils/colors.dart';
import '../../utils/navigation.dart';

class CommonWidget {
  static void showCameraDialog(BuildContext context,
      {required PropertyController propertyController}) async {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.w))),
            insetPadding: const EdgeInsets.all(10),
            actions: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Text(
                      AppString.uploadPic,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 15.w),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () async {
                          var status = await Permission.camera.status;
                          if (!status.isGranted) {
                            Permission.camera.request();
                          }
                          propertyController.image.value =
                              await propertyController.updatePictures(true);
                          Navigation.pop();
                        },
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.camera_alt_outlined, size: 30),
                            SizedBox(width: 10.w),
                            Text(
                             AppString.camera,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(height: 15.w),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () async {
                          var status1 = await Permission.storage.status;
                          if (!status1.isGranted) {
                            Permission.storage.request();
                          }
                          propertyController.image.value =
                              await propertyController.updatePictures(false);
                          Navigation.pop();
                        },
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.collections_outlined, size: 30),
                            SizedBox(width: 10.w),
                            Text(
                             AppString.gallery,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
