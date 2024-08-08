import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/color_table.dart';
import 'package:mapda/constants/definition/font_table.dart';

class AccesibleButton extends StatelessWidget {
  final String thisText;
  final int thisIndex, selectedIndex;
  final VoidCallback thisFunction;

  const AccesibleButton({
    super.key,
    required this.thisText,
    required this.thisIndex,
    required this.selectedIndex,
    required this.thisFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: thisFunction,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.s_w,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                thisIndex == selectedIndex ? AppColors.p_7_base : AppColors.g_4,
            width: 1,
          ),
        ),
        child: Text(
          thisText,
          style: AppTextStyles.R_16.copyWith(
            color:
                thisIndex == selectedIndex ? AppColors.p_7_base : AppColors.g_9,
          ),
        ),
      ),
    );
  }
}
