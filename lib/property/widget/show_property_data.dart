import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowPropertyData extends StatelessWidget {
  const ShowPropertyData(
      {Key? key, required this.propertyName, required this.propertySubTitle})
      : super(key: key);
  final String propertyName;
  final String propertySubTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(propertyName,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
        Text(
          propertySubTitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
