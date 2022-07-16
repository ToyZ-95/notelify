import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/constants/kstyles.dart';

class SnackMessages {
  static final EdgeInsets _snackbarPadding =
      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h);

  static showError(String message) {
    Get.snackbar(
      "",
      "",
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      padding: _snackbarPadding,
      borderRadius: 5.r,
      duration: const Duration(seconds: 2),
      backgroundColor: KStyle.pinkColor,
      titleText: Text(
        message,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
      ),
    );
  }

  static showSuccess(String message) {
    Get.snackbar(
      "",
      "",
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      padding: _snackbarPadding,
      borderRadius: 5.r,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      titleText: Text(
        message,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
      ),
    );
  }
}
