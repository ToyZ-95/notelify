import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/constants/kimages.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/widgets/vertical_space.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  WallpapersController wallpapersController = Get.put(WallpapersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Wallify"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GetBuilder<WallpapersController>(
          builder: (wallpapersController) {
            if (this.wallpapersController.isLoading) {
              return const CircularProgressIndicator.adaptive();
            }

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                  ),
                  VerticalSpace(40.h),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          wallpapersController.getWallpapersByCategory();

          // final first =
          //     FirebaseFirestore.instance.collection("Popular").limit(10);

          // first.get().then((documentSnapshots) {
          //   log("abcd");
          //   for (var doc in documentSnapshots.docs) {
          //     var data = doc.data();
          //     UnsplashWallpaperModel unsplashWallpaperModel =
          //         UnsplashWallpaperModel.fromJson(data);
          //     log(unsplashWallpaperModel.urls!.full!);
          //   }
          // });

          //log(first.toString());
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: const BorderDirectional(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  image: DecorationImage(
                      image: AssetImage(KImages.drawerHeaderImage),
                      fit: BoxFit.fill),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      VerticalSpace(20.h),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
