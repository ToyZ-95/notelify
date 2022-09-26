import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/theme_controller.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/widgets/wallpapers_grid.dart';

class WallpapersListByCategory extends StatelessWidget {
  WallpapersListByCategory({Key? key, required this.categoryName})
      : super(key: key);

  String categoryName;

  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: themeController.darkModeEnabled
          ? const Color(0xff2E2E2E)
          : Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: themeController.darkModeEnabled
            ? const Color(0xff121212)
            : Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            CustomNavigator.instance.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color:
                themeController.darkModeEnabled ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          categoryName,
          style: textTheme.headline1?.copyWith(
              fontSize: 24.sp,
              color: themeController.darkModeEnabled
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: GetBuilder<WallpapersController>(
        builder: (wallpapersController) {
          return WallpapersGrid(
            wallpapers: wallpapersController.wallpapers[categoryName] ?? [],
          );
        },
      ),
    );
  }
}
