import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/screens/home_page.dart';
import 'package:task_flow/screens/login_page.dart';

class LoginVerify extends StatefulWidget {
  const LoginVerify({super.key});

  @override
  State<LoginVerify> createState() => _LoginVerifyState();
}

class _LoginVerifyState extends State<LoginVerify> {
  String token = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    tokenDecript();
  }

  tokenDecript() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('jwt_token');
    // final String? name = prefs.getString('name');
    // print(name);
    token = jwtToken ?? '';
    if (token != '') {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      if (!isTokenExpired) {
        setState(() {
          isLoggedIn = true;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return isLoggedIn ? const MyHomePage() : const LoginPage();
    }
  }
}
