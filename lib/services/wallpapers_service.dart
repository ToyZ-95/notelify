import 'package:cloud_firestore/cloud_firestore.dart';

class WallpapersService {
  WallpapersService._();

  static WallpapersService? _wallpapersService;

  static WallpapersService get instance {
    return _wallpapersService ??= WallpapersService._();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getWallpapersByCategory(
      String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .limit(10)
        .get();
  }
}
