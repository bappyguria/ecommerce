import 'package:flutter/material.dart';
import 'app_colors.dart';


ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,

    // 🌈 Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,

    ),

    scaffoldBackgroundColor: AppColors.background,

    // 🧭 AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,

      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),

    // 🔘 Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),

    // 🧾 Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: Color(0xFFBDBDBD),
        fontSize: 14,
      ),

      // 🔹 HEIGHT CONTROL (important)
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 14,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xFF00B3B3),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF00B3B3),
          width: 1.5,
        ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // 📝 Text Theme
    textTheme: const TextTheme(

    ),
  );
}
