import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        fontFamily: GoogleFonts.archivo().fontFamily,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.courgette().fontFamily,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24.sp,
          ),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        fontFamily: GoogleFonts.archivo().fontFamily,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.courgette().fontFamily,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24.sp,
          ),
        ));
  }
}
