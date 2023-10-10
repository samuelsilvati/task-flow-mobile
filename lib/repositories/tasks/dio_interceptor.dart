import 'package:dio/dio.dart';
import 'package:task_flow/repositories/store.dart';

class Back4AppDioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String jwtToken = await Store.getString('jwt_token');
    options.headers["Authorization"] = "Bearer $jwtToken";

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
