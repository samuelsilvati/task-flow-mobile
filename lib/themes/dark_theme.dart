import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black)),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: Colors.grey.shade800,
      primary: Colors.amber,
      secondary: Colors.amber),
  primarySwatch: Colors.amber,
  textTheme: GoogleFonts.outfitTextTheme(
      const TextTheme(bodyMedium: TextStyle(color: Colors.white))),
  // useMaterial3: true,
);
