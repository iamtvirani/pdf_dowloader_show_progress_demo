import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

BuildContext? _appLoaderContext;

appLoader(BuildContext context) {
  _appLoaderContext = context;
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mediumGreen.withOpacity(0.4),
                      offset: const Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void removeAppLoader() {
  if (_appLoaderContext != null) {
    Navigator.of(_appLoaderContext!).pop();
    _appLoaderContext = null;
  }
}
