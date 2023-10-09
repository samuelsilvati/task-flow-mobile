import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/models/auth/jwt_model.dart';

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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        await prefs.setString('name', jwtModel.name);
        await prefs.setString('sub', jwtModel.sub);
        // print('Token JWT salvo com sucesso.');

        return response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }
}
