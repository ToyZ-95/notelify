import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/constants/kimages.dart';
import 'package:notelify/constants/kstyles.dart';
import 'package:notelify/controllers/user_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/views/login_signup/login.dart';
import 'package:notelify/widgets/vertical_space.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerticalSpace(80.h),
              Text(
                "Verify your Email",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700),
              ),
              VerticalSpace(20.h),
              Image.asset(
                KImages.veryfiEmailImage,
              ),
              VerticalSpace(20.h),
              Text(
                "Check your email ",
                style: TextStyle(
                    color: KStyle.greyColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              VerticalSpace(10.h),
              Text(
                "Click the link to activate your account",
                style: TextStyle(
                    color: KStyle.greyColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              VerticalSpace(100.h),
              GestureDetector(
                onTap: () async {
                  CustomNavigator.instance.replace(context, Login());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFFA578E), Color(0XFFFCAB8E)]),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
              ),
              VerticalSpace(10.h),
              GestureDetector(
                onTap: () async {
                  UserController userController = Get.find();
                  userController.sendVerificationEmail(showSnackMessage: true);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "Resend Email",
                    style: TextStyle(
                        color: const Color(0xFFFA578E), fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
