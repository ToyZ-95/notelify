import 'dart:io';
import 'package:dio/dio.dart';

class DioMethods {
  DioMethods._();

  static DioMethods? _dioMethods;

  static DioMethods get instance {
    _dioMethods ??= DioMethods._();
    return _dioMethods!;
  }

  final Dio _dio = Dio();

  get({required String endPoint, required Map<String, dynamic> params}) async {
    final res = await _dio.get(endPoint, queryParameters: params);

    return res;
  }

  downloadImage(String url, String photoName,
      Function(int received, int total) onReceiveProgress) async {
    try {
      Response response = await _dio.get(
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

      String fullPath = "/storage/emulated/0/Download/$photoName.png";

      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
}
