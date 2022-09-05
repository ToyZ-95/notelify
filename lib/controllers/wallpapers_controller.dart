import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/services/wallpapers_service.dart';

class WallpapersController extends GetxController {
  bool isLoading = false;

  List<String> categories = [];
  //List<UnsplashWallpaperModel> wallpapers = [];

  Map<String, List<UnsplashWallpaperModel>> wallpapers = {};

  ScrollController? scrollController;
  TabController? tabController;

  String selectedCategory = "Popular";
  int limit = 10;
  //QueryDocumentSnapshot<Map<String, dynamic>>? lastVisible;

  Map<String, QueryDocumentSnapshot<Map<String, dynamic>>?>
      categoryWiseLastVisible = {};

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController();
    scrollController!.addListener(() async {
      try {
        var nextPageTrigger = 0.8 * scrollController!.position.maxScrollExtent;

        // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
        if (!isLoading && scrollController!.position.pixels > nextPageTrigger) {
          await getWallpapersByCategory(
              category: categories[tabController!.index]);
        }
      } catch (e) {
        log(e.toString());
      }
      // nextPageTrigger will have a value equivalent to 80% of the list size.
    });
    getCategoriesList();

    getWallpapersByCategory();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.dispose();
  }

  getCategoriesList() {
    WallpapersService.instance.getCategoriesList().then((res) {
      if (res.docs.isNotEmpty) {
        for (var doc in res.docs) {
          categories.add(doc.id);
          if (wallpapers[doc.id] == null) {
            wallpapers[doc.id] = [];
            categoryWiseLastVisible[doc.id] = null;
            getWallpapersByCategory(category: doc.id);
          }
        }
      }
      update();
    });
  }

  getWallpapersByCategory({String category = "Popular"}) {
    isLoading = true;
    update();

    WallpapersService.instance
        .getWallpapersByCategory(
            category: category,
            lastVisibleDoc: categoryWiseLastVisible[category])
        .then((res) {
      if (res != null && res.docs.isNotEmpty) {
        categoryWiseLastVisible[category] = res.docs[res.size - 1];

        List<UnsplashWallpaperModel> walls = [];
        for (var doc in res.docs) {
          walls.add(UnsplashWallpaperModel.fromJson(doc.data()));
        }
        if (wallpapers[category] != null) {
          wallpapers[category]!.addAll(walls);
        } else {
          wallpapers[category] = walls;
        }
      }

      isLoading = false;
      update();
    });
  }
}
