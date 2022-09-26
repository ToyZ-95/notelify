import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/theme_controller.dart';
import 'package:notelify/controllers/user_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/views/login_signup/login.dart';
import 'package:notelify/widgets/vertical_space.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (_) {
        return Drawer(
          backgroundColor: themeController.darkModeEnabled
              ? const Color(0xff2e2e2e)
              : Colors.white,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: themeController.darkModeEnabled
                        ? const Color(0xff121212)
                        : Colors.white,
                    border: const BorderDirectional(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    // image: DecorationImage(
                    //     image: AssetImage(KImages.drawerHeaderImage),
                    //     fit: BoxFit.cover),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xff2e2e2e),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        VerticalSpace(10.h),
                        Text(
                          "Welcome ${FirebaseAuth.instance.currentUser!.displayName!}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: themeController.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        VerticalSpace(10.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        CustomNavigator.instance.replace(context, Login());
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: themeController.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        const Spacer(),
                        Icon(Icons.logout,
                            color: themeController.darkModeEnabled
                                ? Colors.white
                                : Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
