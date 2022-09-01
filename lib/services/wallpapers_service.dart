import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notelify/controllers/wallpapers_controller.dart';

class WallpapersService {
  WallpapersService._();

  static WallpapersService? _wallpapersService;

  static WallpapersService get instance {
    return _wallpapersService ??= WallpapersService._();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategoriesList() async {
    return await FirebaseFirestore.instance.collection("Categories").get();
  }

  ///Fetchs wallpapers from firebase
  ///Takes WallpaperController object to get selected category, limit of page, document from where to start fetching
  Future<QuerySnapshot<Map<String, dynamic>>?> getWallpapersByCategory(
      WallpapersController wallpapersController) async {
    try {
      if (wallpapersController.lastVisible == null) {
        return await FirebaseFirestore.instance
            .collection(wallpapersController.selectedCategory)
            .limit(wallpapersController.limit)
            .get();
      } else {
        return await FirebaseFirestore.instance
            .collection(wallpapersController.selectedCategory)
            .startAfterDocument(wallpapersController.lastVisible!)
            .limit(wallpapersController.limit)
            .get();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
