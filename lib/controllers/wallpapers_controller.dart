import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/services/wallpapers_service.dart';

class WallpapersController extends GetxController {
  bool isLoading = false;

  List<UnsplashWallpaperModel> wallpapers = [];
  ScrollController? scrollController;

  String selectedCategory = "Popular";
  int limit = 10;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastVisible;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController!.addListener(() async {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * scrollController!.position.maxScrollExtent;

      // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (!isLoading && scrollController!.position.pixels > nextPageTrigger) {
        await getWallpapersByCategory();
      }
    });
    getWallpapersByCategory();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.dispose();
  }

  getWallpapersByCategory({String category = "Popular"}) async {
    isLoading = true;
    update();
    final QuerySnapshot<Map<String, dynamic>>? res =
        await WallpapersService.instance.getWallpapersByCategory(this);

    if (res != null && res.docs.isNotEmpty) {
      lastVisible = res.docs[res.size - 1];

      for (var doc in res.docs) {
        wallpapers.add(UnsplashWallpaperModel.fromJson(doc.data()));
      }
    }

    isLoading = false;
    update();
  }
}
