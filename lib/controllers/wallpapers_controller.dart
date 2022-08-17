import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/services/wallpapers_service.dart';

class WallpapersController extends GetxController {
  bool isLoading = false;

  List<UnsplashWallpaperModel> wallpapers = [];

  getWallpapersByCategory({String category = "Popular"}) async {
    isLoading = true;
    update();
    final QuerySnapshot<Map<String, dynamic>> res =
        await WallpapersService.instance.getWallpapersByCategory(category);
    for (var doc in res.docs) {
      wallpapers.add(UnsplashWallpaperModel.fromJson(doc.data()));
    }
    isLoading = false;
    update();
  }
}
