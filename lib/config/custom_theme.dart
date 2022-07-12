import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        //fontFamily: GoogleFonts.archivo().fontFamily,
        textTheme: TextTheme(
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 24.sp,
      ),
    ));
  }
}
