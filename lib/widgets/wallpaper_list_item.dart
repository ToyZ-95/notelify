import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/views/wallpaper_details/wallpaper_details.dart';

class WallpaperListItem extends StatelessWidget {
  WallpaperListItem(
      {Key? key, required this.categoryIndex, required this.imageIndexInList})
      : super(key: key);

  int categoryIndex;
  int imageIndexInList;

  WallpapersController wallpapersController = Get.find();
  UnsplashWallpaperModel? unsplashWallpaperModel;

  @override
  Widget build(BuildContext context) {
    unsplashWallpaperModel = wallpapersController.wallpapers[
        wallpapersController.categories[categoryIndex]]![imageIndexInList];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        CustomNavigator.instance.to(
            context,
            WallpaperDetails(
              unsplashWallpaperModel: unsplashWallpaperModel!,
            ),
            () {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-1, 1),
                  color: Colors.black54.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 5)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: CachedNetworkImage(
            useOldImageOnUrlChange: true,
            imageUrl: unsplashWallpaperModel!.urls!.thumb!,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
