import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/theme_controller.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/views/wallpaper_details/wallpaper_details.dart';

class WallpaperListItem extends StatelessWidget {
  WallpaperListItem({Key? key, required this.unsplashWallpaperModel})
      : super(key: key);

  ThemeController themeController = Get.find();

  WallpapersController wallpapersController = Get.find();

  UnsplashWallpaperModel unsplashWallpaperModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        CustomNavigator.instance.to(
            context,
            WallpaperDetails(
              unsplashWallpaperModel: unsplashWallpaperModel,
            ),
            () {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 1),
                  color: themeController.darkModeEnabled
                      ? Colors.black54.withOpacity(0.3)
                      : Colors.black54.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: CachedNetworkImage(
            useOldImageOnUrlChange: true,
            imageUrl: unsplashWallpaperModel.urls!.regular!,
            fit: BoxFit.fill,
            placeholder: (BuildContext context, _) {
              return CachedNetworkImage(
                fit: BoxFit.fill,
                useOldImageOnUrlChange: true,
                imageUrl: unsplashWallpaperModel.urls!.thumb!,
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
