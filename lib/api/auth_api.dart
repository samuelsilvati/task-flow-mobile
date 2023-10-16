import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:task_flow/models/auth/jwt_model.dart';
import 'package:task_flow/repositories/store.dart';

class AuthUser {
  static final _url = dotenv.get("API_URL");

  Future signIn(String email, String password) async {
    try {
      final dio = Dio();
      dio.options.headers["Content-type"] = "application/json";
      final response = await dio
          .post("$_url/auth", data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final String token = response.data['token'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        JwtModel jwtModel = JwtModel.fromJson(decodedToken);

        Store.saveString('jwt_token', token);
        Store.saveString('name', jwtModel.name);
        Store.saveString('sub', jwtModel.sub);

        return response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future signUp(String name, String email, String password) async {
    try {
      final dio = Dio();
      dio.options.headers["Content-type"] = "application/json";
      final response = await dio.post("$_url/signup",
          data: {'name': name, 'email': email, 'password': password});
      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }
}
