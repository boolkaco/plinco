import 'package:flutter/material.dart';
import 'package:plinco/theme/app_colors.dart';
import 'package:plinco/theme/app_branding_colors.dart';

class AppTheme {
  static const String fontFamily = "Nunito";

  static ThemeData get lightTheme {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.cornflowerBlue),
      primaryColor: AppColors.cornflowerBlue,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),
      dividerColor: AppColors.silver.withOpacity(0.2),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.cornflowerBlue,
        unselectedItemColor: AppColors.black,
        selectedIconTheme: IconThemeData(
          color: AppColors.cornflowerBlue,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.cornflowerBlue,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.black,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.silver),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cornflowerBlue),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.silver),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 14,
          color: AppColors.white,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: AppColors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: AppColors.white,
          fontFamily: fontFamily,
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.cornflowerBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(color: AppColors.white, width: 1)
          ),
        ),
      ),
      useMaterial3: true,
    ).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const AppBrandingColors(
            color: AppColors.cornflowerBlue,
          ),
        ]
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.silver,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.cornflowerBlue),
      primaryColor: AppColors.cornflowerBlue,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.silver,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      dividerColor: AppColors.silver.withOpacity(0.2),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.silver,
        selectedItemColor: AppColors.cornflowerBlue,
        unselectedItemColor: AppColors.white,
        unselectedIconTheme: IconThemeData(
          color: AppColors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.white,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.silver),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cornflowerBlue),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.silver),
        ),
      ),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 14,
            color: AppColors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 16,
            color: AppColors.white,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.cornflowerBlue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: AppColors.white, width: 1)
          ),
        ),
      ),
      useMaterial3: true,
    ).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const AppBrandingColors(
            color: AppColors.cornflowerBlue,
          ),
        ]
    );
  }
}
