import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/widgets/vertical_space.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  WallpapersController wallpapersController = Get.put(WallpapersController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpapersController>(
      builder: (wallpapersController) {
        if (wallpapersController.isLoading &&
            wallpapersController.wallpapers.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return DefaultTabController(
          length: wallpapersController.categories.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 1.0,
              automaticallyImplyLeading: false,
              leading: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              title: const Text(
                "Wallify",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: const Color(0xffFAFAFA),
              bottom: TabBar(
                tabs: List.generate(
                    wallpapersController.categories.length,
                    (index) => Text(
                          wallpapersController.categories[index],
                          style: const TextStyle(color: Colors.black),
                        )),
              ),
            ),
            body: TabBarView(
                children: List.generate(wallpapersController.categories.length,
                    (index) {
              return GridView.builder(
                controller: wallpapersController.scrollController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: wallpapersController
                    .wallpapers[wallpapersController.selectedCategory]!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: wallpapersController
                          .wallpapers[wallpapersController.selectedCategory]![
                              index]
                          .urls!
                          .thumb!,
                      height: 400.h,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              );
            })

                //    [
                //   Icon(Icons.directions_car),
                //   Icon(Icons.directions_transit),
                //   Icon(Icons.directions_bike),
                // ]
                // GridView.builder(
                //   controller: wallpapersController.scrollController,
                //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: 200,
                //     childAspectRatio: 1 / 2,
                //     crossAxisSpacing: 20,
                //     mainAxisSpacing: 20,
                //   ),
                //   itemCount: wallpapersController.wallpapers.length,
                //   itemBuilder: (BuildContext ctx, index) {
                //     return Container(
                //       margin: const EdgeInsets.all(8),
                //       decoration:
                //           BoxDecoration(borderRadius: BorderRadius.circular(15)),
                //       child: CachedNetworkImage(
                //         imageUrl:
                //             wallpapersController.wallpapers[index].urls!.thumb!,
                //         height: 400.h,
                //         fit: BoxFit.cover,
                //         progressIndicatorBuilder:
                //             (context, url, downloadProgress) => Center(
                //           child: SizedBox(
                //             height: 20.h,
                //             width: 20.w,
                //             child: CircularProgressIndicator(
                //               value: downloadProgress.progress,
                //             ),
                //           ),
                //         ),
                //         errorWidget: (context, url, error) =>
                //             const Icon(Icons.error),
                //       ),
                //     );
                //   },
                // ),
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
                      decoration: const BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                        // image: DecorationImage(
                        //     image: AssetImage(KImages.drawerHeaderImage),
                        //     fit: BoxFit.fill),
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
          ),
        );
      },
    );
  }
}
