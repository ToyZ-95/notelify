import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class WallpapersService {
  WallpapersService._();

  static WallpapersService? _wallpapersService;

  static WallpapersService get instance {
    return _wallpapersService ??= WallpapersService._();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategoriesList() async {
    return await FirebaseFirestore.instance.collection("Categories").get();
  }

  int wallpapersLimitPerPage = 10;

  ///Fetchs wallpapers from firebase
  ///Takes WallpaperController object to get selected category, limit of page, document from where to start fetching
  Future<QuerySnapshot<Map<String, dynamic>>?> getWallpapersByCategory(
      {required String category,
      QueryDocumentSnapshot<Map<String, dynamic>>? lastVisibleDoc}) async {
    try {
      if (lastVisibleDoc == null) {
        return await FirebaseFirestore.instance
            .collection(category)
            .limit(wallpapersLimitPerPage)
            .get();
      } else {
        return await FirebaseFirestore.instance
            .collection(category)
            .startAfterDocument(lastVisibleDoc)
            .limit(wallpapersLimitPerPage)
            .get();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
