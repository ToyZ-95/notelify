import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';
import 'package:notelify/widgets/custom_drawer.dart';
import 'package:notelify/widgets/wallpaper_list_item.dart';

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
        wallpapersController.tabController ??= TabController(
            length: wallpapersController.categories.length,
            vsync: this,
            initialIndex: 1);

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
              isScrollable: true,
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
              (index) {
                return GridView.builder(
                  controller: wallpapersController.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: .65,
                  ),
                  itemCount: wallpapersController
                      .wallpapers[wallpapersController.categories[index]]!
                      .length,
                  itemBuilder: (BuildContext ctx, i) {
                    return WallpaperListItem(
                      categoryIndex: index,
                      imageIndexInList: i,
                    );
                  },
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
