import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/services/wallpapers_service.dart';

class WallpapersController extends GetxController {
  bool isLoading = false;

  List<String> categories = [];

  Map<String, List<UnsplashWallpaperModel>> wallpapers = {};

  ScrollController? scrollController;
  TabController? tabController;

  String selectedCategory = "Latest";
  int limit = 10;
  int latestPageNumber = 1;
  int popularPageNumber = 1;

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
          if (selectedCategory.isEmpty) {
            return;
          }
          if (selectedCategory == "Latest") {
            latestPageNumber += 1;
            if (latestPageNumber <= 3) {
              await getWallpapersFromUnsplashAPI(pageNumber: latestPageNumber);
            }
            return;
          }
          if (selectedCategory == "Popular") {
            popularPageNumber += 1;
            if (popularPageNumber <= 3) {
              await getWallpapersFromUnsplashAPI(
                  orderBy: "Popular", pageNumber: popularPageNumber);
            }

            return;
          }
          await getWallpapersByCategoryFromFireBase(category: selectedCategory);
        }
      } catch (e) {
        log(e.toString());
      }
      // nextPageTrigger will have a value equivalent to 80% of the list size.
    });
    getCategoriesList();

    getWallpapersFromUnsplashAPI();
    getWallpapersFromUnsplashAPI(orderBy: "Popular");

    getWallpapersByCategoryFromFireBase();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.dispose();
  }

  initTabController(
      {required int initialIndex,
      required int length,
      required TickerProvider tickerProvider}) {
    tabController = TabController(
      length: 3,
      vsync: tickerProvider,
      initialIndex: 1,
    );

    tabController?.addListener(() {
      if (tabController?.index == 1) {
        selectedCategory = "Latest";
      } else if (tabController?.index == 2) {
        selectedCategory = "Popular";
      } else {
        selectedCategory = "";
      }
    });
  }

  getCategoriesList() {
    WallpapersService.instance.getCategoriesList().then((res) {
      if (res.docs.isNotEmpty) {
        for (var doc in res.docs) {
          categories.add(doc.id);
          //getFirstWallpaperByCategoryFromFireBase(doc.id);

          if (wallpapers[doc.id] == null) {
            wallpapers[doc.id] = [];
            categoryWiseLastVisible[doc.id] = null;
            getWallpapersByCategoryFromFireBase(category: doc.id);
          }
        }
      }
      update();
    });
  }

  getWallpapersByCategoryFromFireBase({String category = "Popular"}) {
    isLoading = true;
    update();

    WallpapersService.instance
        .getWallpapersByCategoryFromFireBase(
            category: category,
            lastVisibleDoc: categoryWiseLastVisible[category])
        .then((res) {
      if (res != null && res.docs.isNotEmpty) {
        categoryWiseLastVisible[category] = res.docs[res.size - 1];

        for (var doc in res.docs) {
          createUnsplashWallpaperModelAndAddToList(
              data: doc.data(), category: category);
        }
      }

      isLoading = false;
      update();
    });
  }

  getWallpapersFromUnsplashAPI(
      {String orderBy = "Latest", int pageNumber = 1}) async {
    isLoading = true;
    update();
    await WallpapersService.instance
        .getWallpapersFromUnsplashAPI(orderBy: orderBy, pageNumber: pageNumber)
        .then((res) {
      for (var data in res) {
        createUnsplashWallpaperModelAndAddToList(data: data, category: orderBy);
      }
      isLoading = false;
      update();
    });
  }

  createUnsplashWallpaperModelAndAddToList(
      {required Map<String, dynamic> data, required String category}) {
    UnsplashWallpaperModel unsplashWallpaperModel =
        UnsplashWallpaperModel.fromJson(data);

    if (wallpapers[category] != null) {
      wallpapers[category]!.add(unsplashWallpaperModel);
    } else {
      wallpapers[category] = [unsplashWallpaperModel];
    }
  }
}
