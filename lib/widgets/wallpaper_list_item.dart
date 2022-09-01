import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';

class WallpaperListItem extends StatelessWidget {
  WallpaperListItem(
      {Key? key, required this.categoryIndex, required this.imageIndexInList})
      : super(key: key);

  int categoryIndex;
  int imageIndexInList;

  WallpapersController wallpapersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.r), boxShadow: [
        BoxShadow(
            offset: const Offset(-1, 1),
            color: Colors.black54.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 5)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CachedNetworkImage(
          imageUrl: wallpapersController
              .wallpapers[wallpapersController.categories[categoryIndex]]![
                  imageIndexInList]
              .urls!
              .regular!,
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CachedNetworkImage(
              imageUrl: wallpapersController
                  .wallpapers[wallpapersController.categories[categoryIndex]]![
                      imageIndexInList]
                  .urls!
                  .thumb!,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
