import 'package:flutter/material.dart';
import 'package:mapda/constants/constants.dart';

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
    );
  }
}
