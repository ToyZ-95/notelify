import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/config/custom_theme.dart';
import 'package:notelify/controllers/user_controller.dart';
import 'package:notelify/views/dashboard/dashboard.dart';
import 'package:notelify/views/login_signup/login.dart';

bool goToHomePage = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(UserController());
  if (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified) {
    goToHomePage = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          home: goToHomePage ? Dashboard() : Login(),
        );
      },
    );
  }
}
