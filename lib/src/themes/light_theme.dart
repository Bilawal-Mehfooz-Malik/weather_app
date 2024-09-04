import 'package:flutter/material.dart';

const greyTextColor = Color(0xFF757575);
final textFieldFillColor = const Color(0xFF979797).withOpacity(0.1);
const elevatedBtnBgColor = Color.fromARGB(255, 19, 51, 148);
const elevatedBtnTxtColor = Colors.white;

const border = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: elevatedBtnBgColor),

  // Search Field Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    fillColor: textFieldFillColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(elevatedBtnBgColor),
      foregroundColor: WidgetStatePropertyAll(elevatedBtnTxtColor),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)))),
    ),
  ),
);
