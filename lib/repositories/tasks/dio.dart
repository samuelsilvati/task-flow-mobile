import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_flow/repositories/tasks/dio_interceptor.dart';

class CustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("API_URL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
