import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/color_table.dart';
import 'package:mapda/constants/definition/font_table.dart';

class CustomSnackbar {
  static SnackBar create({
    required String message,
    required String actionLabel,
    required VoidCallback? onAction,
  }) {
    return SnackBar(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: AppColors.g_10,
        duration: const Duration(seconds: 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: AppTextStyles.R_14.copyWith(color: AppColors.g_2),
            ),
            SizedBox(
              height: 36,
              child: TextButton(
                  clipBehavior: Clip.none,
                  onPressed: onAction,
                  child: Text(
                    actionLabel,
                    style: AppTextStyles.B_14.copyWith(color: AppColors.p_6),
                  )),
            )
          ],
        ));
  }
}
