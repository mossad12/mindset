import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle _textStyle ({required Color color, required double fontSize , required FontWeight fontWeight}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight
  );
}

TextStyle textStyleBold ({required Color color, required double fontSize}) {
  return _textStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w700);
}
TextStyle textStyleRegular ({required Color color, required double fontSize}) {
  return _textStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w400);
}
TextStyle textStyleMedium ({required Color color, required double fontSize}) {
  return _textStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w500);
}