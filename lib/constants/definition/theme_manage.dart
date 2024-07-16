import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class ThemeManage {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.s_w,
      bottomAppBarTheme: const BottomAppBarTheme(
        padding: EdgeInsets.zero,
        height: 70,
        elevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.R_16.copyWith(color: AppColors.g_5),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
