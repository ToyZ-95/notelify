import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/views/wallpapers_grid_by_category/wallpapers_grid_by_category.dart';
import 'package:notelify/widgets/category_card.dart';
import 'package:notelify/widgets/custom_drawer.dart';
import 'package:notelify/widgets/vertical_space.dart';
import 'package:notelify/widgets/wallpapers_grid.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  WallpapersController wallpapersController = Get.put(WallpapersController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GetBuilder<WallpapersController>(
      builder: (wallpapersController) {
        if (wallpapersController.isLoading &&
            wallpapersController.wallpapers.isEmpty) {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (wallpapersController.tabController == null) {
          wallpapersController.initTabController(
            initialIndex: 1,
            length: 3,
            tickerProvider: this,
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1.0,
            automaticallyImplyLeading: false,
            leading: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            title: Text(
              "Wallify",
              style: textTheme.headline1,
            ),
            backgroundColor: const Color(0xffFAFAFA),
            bottom: TabBar(
              isScrollable: false,
              controller: wallpapersController.tabController,
              indicatorColor: Colors.black,
              tabs: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    index == 0
                        ? "Category"
                        : index == 1
                            ? "Latest"
                            : "Popular",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: wallpapersController.tabController,
            children: List.generate(
              3,
              (int index) {
                if (index == 0) {
                  if (wallpapersController.isLoading) {
                    return const SizedBox();
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        VerticalSpace(20.h),
                        ...List.generate(wallpapersController.categories.length,
                            (index) {
                          String categoryName =
                              wallpapersController.categories[index];

                          int randomInt = Random().nextInt(wallpapersController
                              .wallpapers[categoryName]!.length);

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              CustomNavigator.instance.to(
                                  context,
                                  WallpapersListByCategory(
                                      categoryName: categoryName),
                                  () {});
                            },
                            child: CategoryCard(
                              textTheme: textTheme,
                              name: categoryName,
                              wallpaperLink: wallpapersController
                                  .wallpapers[categoryName]![randomInt]
                                  .urls!
                                  .regular!,
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }

                List<UnsplashWallpaperModel>? wallpapersList;

                if (index == 1) {
                  if (wallpapersController.wallpapers["Latest"] == null) {
                    return const SizedBox();
                  } else {
                    wallpapersList = wallpapersController.wallpapers["Latest"];
                  }
                } else if (index == 2) {
                  if (wallpapersController.wallpapers["Popular"] == null) {
                    return const SizedBox();
                  } else {
                    wallpapersList = wallpapersController.wallpapers["Popular"];
                  }
                }

                return WallpapersGrid(
                  wallpapers: wallpapersList ?? [],
                );
              },
            ),
          ),
          drawer: const CustomDrawer(),
        );
      },
    );
  }
}
