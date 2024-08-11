import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class ThemeManage {
  static ThemeData get theme {
    return ThemeData(
      canvasColor: Colors.white,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.s_w,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.s_w,
        padding: EdgeInsets.zero,
        height: 70,
        elevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.R_16.copyWith(color: AppColors.g_5),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.p_7_base,
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.s_w,
        centerTitle: false,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.s_w,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.s_w,
      ),
    );
  }
}
