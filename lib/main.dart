import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_flow/my_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
