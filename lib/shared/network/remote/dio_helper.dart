import 'package:dio/dio.dart';

// news App
// static init() {
//   dio = Dio(BaseOptions(
//     baseUrl: 'https://newsapi.org/',
//     receiveDataWhenStatusError: true,
//   ));
// }

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
    ),);
  }

  static Future<Response?> getData({
    required String url,
     Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token??'',
    };
    return await dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    String lang = 'en',
    String? token,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio?.post(url, queryParameters: query, data: data);
  }

  static Future<Response?> putData({
    required String url,
    String lang = 'en',
    String? token,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio?.put(url, queryParameters: query, data: data);
  }
}
