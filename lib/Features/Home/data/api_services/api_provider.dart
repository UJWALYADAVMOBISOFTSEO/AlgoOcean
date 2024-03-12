import 'package:algoocean/Features/Home/data/model/HomeModal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HomeApiServices {
  final Dio _dio = Dio();

  Future<HomeModal> getHomeData() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Response response = await _dio.get(
          'https://dog.ceo/api/breeds/image/random',
          options: Options(validateStatus: (_) => true, headers: headers));
      return HomeModal.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint('Exception occured: $error stackTrace: $stacktrace');
      throw 'Home Page error ';
    }
  }
}
