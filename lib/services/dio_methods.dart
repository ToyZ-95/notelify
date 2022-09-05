import 'dart:io';
import 'package:dio/dio.dart';

class DioMethods {
  DioMethods._();

  static DioMethods? _dioMethods;

  static DioMethods get instance {
    _dioMethods ??= DioMethods._();
    return _dioMethods!;
  }

  Dio dio = Dio();

  get({required String endPoint, required Map<String, dynamic> params}) async {
    final res = await dio.get(endPoint, queryParameters: params);

    return res;
  }

  downloadImage(String url, String photoName,
      Function(int received, int total) onReceiveProgress) async {
//     var tempDir = await getApplicationDocumentsDirectory();

// //Directory appDocDirectory = await getApplicationDocumentsDirectory();

//     Directory directory =
//         await Directory('${tempDir.path}/dir').create(recursive: true);
// // The created directory is returned as a Future.

//     String fullPath = "${directory.path}/$photoName.png";
//     print('full path $fullPath');

    //await dio.download(url, fullPath);

    //await GallerySaver.saveImage(fullPath);

    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status == null ? false : status < 500;
            }),
      );
      print(response.headers);

      //await GallerySaver.saveImage(fullPath);

      //writeFile( response.data);
      String fullPath = "/storage/emulated/0/Download/$photoName.png";

      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
}
