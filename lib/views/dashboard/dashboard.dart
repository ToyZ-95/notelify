import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notelify/widgets/vertical_space.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                ),
                VerticalSpace(40.h),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
