import 'package:flutter/material.dart';
import 'package:task_flow/screens/login_verify.dart';
import 'package:task_flow/themes/dark_theme.dart';
import 'package:task_flow/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Flow',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginVerify(),
    );
  }
}
