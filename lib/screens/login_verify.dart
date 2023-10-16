import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:task_flow/repositories/store.dart';
import 'package:task_flow/screens/home_page.dart';
import 'package:task_flow/screens/login_page.dart';

class LoginVerify extends StatefulWidget {
  const LoginVerify({super.key});

  @override
  State<LoginVerify> createState() => _LoginVerifyState();
}

class _LoginVerifyState extends State<LoginVerify> {
  String token = '';
  @override
  void initState() {
    super.initState();
    tokenDecript();
  }

  tokenDecript() async {
    final String jwtToken = await Store.getString('jwt_token');
    token = jwtToken;
    if (token != '') {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      if (!isTokenExpired) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      ),
    );
  }
}
