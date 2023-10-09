import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Flow',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            primary: Colors.amber,
            secondary: Colors.amber),
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.outfitTextTheme(
            const TextTheme(bodyMedium: TextStyle(color: Colors.black))),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Flow'),
    );
  }
}
