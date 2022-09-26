import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/theme_controller.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ThemeController themeController = Get.find();
  WallpapersController wallpapersController = Get.put(WallpapersController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GetBuilder<ThemeController>(
      builder: (_) {
        return GetBuilder<WallpapersController>(
          builder: (_) {
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
              key: _scaffoldKey,
              backgroundColor: themeController.darkModeEnabled
                  ? const Color(0xff2E2E2E)
                  : Colors.white,
              appBar: AppBar(
                elevation: 1.0,
                automaticallyImplyLeading: false,
                backgroundColor: themeController.darkModeEnabled
                    ? const Color(0xff121212)
                    : const Color(0xffFAFAFA),
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: themeController.darkModeEnabled
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                title: Text(
                  "Wallify",
                  style: themeController.darkModeEnabled
                      ? textTheme.headline1?.copyWith(color: Colors.white)
                      : textTheme.headline1,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      themeController.toggleDarkMode();
                    },
                    icon: Icon(
                      themeController.darkModeEnabled
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: themeController.darkModeEnabled
                          ? Colors.white
                          : const Color(0xff2e2e2e),
                    ),
                  )
                ],
                bottom: TabBar(
                  isScrollable: false,
                  controller: wallpapersController.tabController,
                  indicatorColor: themeController.darkModeEnabled
                      ? Colors.white
                      : Colors.black,
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
                        style: TextStyle(
                            color: themeController.darkModeEnabled
                                ? Colors.white
                                : Colors.black),
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
                            ...List.generate(
                                wallpapersController.categories.length,
                                (index) {
                              String categoryName =
                                  wallpapersController.categories[index];

                              if (wallpapersController
                                  .wallpapers[categoryName]!.isEmpty) {
                                return const SizedBox();
                              }

                              int randomInt = Random().nextInt(
                                  wallpapersController
                                      .wallpapers[categoryName]!.length);

                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  wallpapersController.selectedCategory =
                                      categoryName;
                                  CustomNavigator.instance.to(
                                      context,
                                      WallpapersListByCategory(
                                          categoryName: categoryName), () {
                                    wallpapersController.selectedCategory = "";
                                  });
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
                        wallpapersList =
                            wallpapersController.wallpapers["Latest"];
                      }
                    } else if (index == 2) {
                      if (wallpapersController.wallpapers["Popular"] == null) {
                        return const SizedBox();
                      } else {
                        wallpapersList =
                            wallpapersController.wallpapers["Popular"];
                      }
                    }

                    return WallpapersGrid(
                      wallpapers: wallpapersList ?? [],
                    );
                  },
                ),
              ),
              drawer: CustomDrawer(),
            );
          },
        );
      },
    );
  }
}
