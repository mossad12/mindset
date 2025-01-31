import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_list/ui/utils/AppColors.dart';
import 'package:to_do_list/ui/utils/AppFonts.dart';


class AppThemes{

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.primaryColor
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      titleLarge: textStyleBold(color: AppColors.primaryColor , fontSize:18),
      titleMedium: textStyleBold(color: AppColors.blackColor , fontSize:16),
      titleSmall: textStyleBold(color: AppColors.primaryColor , fontSize:14),

    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.primaryColor
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.primaryColor
        ),
      )
    ),
  );

}