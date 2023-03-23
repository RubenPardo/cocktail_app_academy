import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:cocktail_app_academy/core/constants.dart';

class Request {
  final Dio _dio = Dio();
  Request() {
    updateDioInterceptors();
  }

  void updateAuthorization(String token) {
    _dio.options.headers['authorization'] = 'Bearer $token';
  }

  void updateDioInterceptors() {
    _dio.options = BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: Constants.baseUrl,
      validateStatus: (value) {
        return value! <= 500;
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    _dio.interceptors.add(
        LogInterceptor(
          requestBody: kDebugMode ? true : false,
          responseBody: kDebugMode ? true : false,
          requestHeader: kDebugMode ? true : false,
        ),
      );
  }

  // requests
  Future<Response> get(String path, {Map<String,dynamic>? headers}) async {
    if(headers!=null){
      _dio.options.headers.addAll(headers);
    }
    return await _dio.get(path);
  }

  Future<Response> post(String path, {Object? data}) async {
    return await _dio.post(path, data: data);
  }
}