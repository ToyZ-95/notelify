import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/theme_controller.dart';
import 'package:notelify/controllers/wallpaper_details_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:photo_view/photo_view.dart';

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

  ThemeController themeController = Get.find();

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
            child: PhotoView(
              loadingBuilder: ((context, event) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: themeController.darkModeEnabled
                      ? const Color(0xff2E2E2E)
                      : Colors.white,
                  child: Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        color: themeController.darkModeEnabled
                            ? Colors.white
                            : const Color(0xff2e2e2e),
                      ),
                    ),
                  ),
                );
              }),
              backgroundDecoration: BoxDecoration(
                color: themeController.darkModeEnabled
                    ? const Color(0xff2E2E2E)
                    : Colors.white,
              ),
              initialScale: 0.15,
              minScale: 0.1,
              imageProvider: NetworkImage(
                wallpaperDetailsController.unsplashWallpaperModel!.urls!.full!,
              ),
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
