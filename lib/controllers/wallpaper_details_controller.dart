import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/models/unsplash_wallpaper_model.dart';
import 'package:notelify/services/dio_methods.dart';
import 'package:permission_handler/permission_handler.dart';

class WallpaperDetailController extends GetxController {
  String downloadingProgress = "";

  UnsplashWallpaperModel? unsplashWallpaperModel;

  @override
  void dispose() {
    // TODO: implement dispose
    downloadingProgress = "";
    super.dispose();
  }

  Future downloadImage() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        DioMethods.instance.downloadImage(
            unsplashWallpaperModel!.urls!.full!,
            unsplashWallpaperModel!.id!,
            (received, total) => showDownloadProgress(received, total));
      }
    } else {
      DioMethods.instance.downloadImage(
          unsplashWallpaperModel!.urls!.full!,
          unsplashWallpaperModel!.id!,
          (received, total) => showDownloadProgress(received, total));
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      downloadingProgress = (received / total * 100).toStringAsFixed(0) + "%";
      print(downloadingProgress);
      update();
    }
  }
}
