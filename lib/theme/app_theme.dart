import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;
  static const Color marvelWhite = Color(0xFFFEFEFE);
  static const Color marvelRed = Color(0xFFEC1D24);
  static const Color marvelGrey = Color(0xFF202020);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: marvelGrey,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: marvelRed,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: marvelRed,
    ),
  );
}
