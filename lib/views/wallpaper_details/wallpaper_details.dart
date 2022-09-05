import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpaper_details_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';

class WallpaperDetails extends StatefulWidget {
  UnsplashWallpaperModel unsplashWallpaperModel;

  WallpaperDetails({Key? key, required this.unsplashWallpaperModel})
      : super(key: key);

  @override
  State<WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<WallpaperDetails> {
  WallpaperDetailController wallpaperDetailsController =
      Get.put(WallpaperDetailController());

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<WallpaperDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    wallpaperDetailsController.unsplashWallpaperModel =
        widget.unsplashWallpaperModel;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: wallpaperDetailsController
                  .unsplashWallpaperModel!.urls!.full!,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const SizedBox(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 50.h,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      wallpaperDetailsController.downloadImage();
                    },
                    child: GetBuilder<WallpaperDetailController>(
                      builder: (wallpaperDetailsController) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: this
                                  .wallpaperDetailsController
                                  .downloadingProgress
                                  .isEmpty
                              ? const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                )
                              : Text(
                                  this
                                      .wallpaperDetailsController
                                      .downloadingProgress,
                                  style: const TextStyle(color: Colors.white),
                                ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
