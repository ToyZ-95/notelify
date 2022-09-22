import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/widgets/wallpapers_grid.dart';

class WallpapersListByCategory extends StatelessWidget {
  WallpapersListByCategory({Key? key, required this.categoryName})
      : super(key: key);

  String categoryName;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    WallpapersController wallpapersController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            CustomNavigator.instance.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          categoryName,
          style: textTheme.headline1?.copyWith(fontSize: 24.sp),
        ),
      ),
      body: WallpapersGrid(
        wallpapers: wallpapersController.wallpapers[categoryName] ?? [],
      ),
    );
  }
}
