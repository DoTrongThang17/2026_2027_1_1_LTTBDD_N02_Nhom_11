import 'package:flutter/material.dart';

const Color mauChinh = Color(0xFFFF5500);
const Color mauNen = Color(0xFFF5F5F5);
const Color mauNenToi = Color(0xFF121212);
const Color mauTheToi = Color(0xFF1E1E1E);

ThemeData taoTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: mauChinh,
      primary: mauChinh,
    ),
    scaffoldBackgroundColor: mauNen,
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: mauChinh,
      thumbColor: mauChinh,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: mauChinh,
      unselectedItemColor: Colors.black54,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

ThemeData taoThemeToi() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: mauChinh,
      primary: mauChinh,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: mauNenToi,
    cardColor: mauTheToi,
    appBarTheme: const AppBarTheme(
      backgroundColor: mauNenToi,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: mauChinh,
      thumbColor: mauChinh,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: mauTheToi,
      selectedItemColor: mauChinh,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
