import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/widgets/wallpaper_list_item.dart';

class WallpapersGrid extends StatelessWidget {
  WallpapersGrid({
    Key? key,
    required this.wallpapers,
  }) : super(key: key);

  List<UnsplashWallpaperModel> wallpapers;

  WallpapersController wallpapersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: wallpapersController.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: .65,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (BuildContext ctx, int i) {
        UnsplashWallpaperModel unsplashWallpaperModel = wallpapers[i];

        return WallpaperListItem(
          unsplashWallpaperModel: unsplashWallpaperModel,
        );
      },
    );
  }
}
