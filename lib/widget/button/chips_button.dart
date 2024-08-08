import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class ChipsButton extends StatelessWidget {
  final int thisIndex, selectedIndex;
  final String thisText;
  final VoidCallback thisTap;

  const ChipsButton({
    super.key,
    required this.thisIndex,
    required this.selectedIndex,
    required this.thisText,
    required this.thisTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: thisTap,
      child: Ink(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color:
              thisIndex == selectedIndex ? AppColors.p_7_base : AppColors.s_w,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                thisIndex == selectedIndex ? AppColors.p_7_base : AppColors.g_3,
          ),
        ),
        child: Center(
          child: Text(
            thisText,
            style: AppTextStyles.B_14.copyWith(
              color:
                  thisIndex == selectedIndex ? AppColors.s_w : AppColors.g_10,
            ),
          ),
        ),
      ),
    );
  }
}
