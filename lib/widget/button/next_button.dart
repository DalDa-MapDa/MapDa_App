import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? thisTap;
  final bool? isReady;
  final String thisText;

  const NextButton({
    super.key,
    this.thisTap,
    this.isReady,
    required this.thisText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: (isReady ?? false) ? thisTap : null, // 조건에 맞게 onTap 설정
        child: Ink(
          height: 48,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _getColor(),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              thisText,
              style: AppTextStyles.B_14.copyWith(color: AppColors.s_w),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    // isReady가 null이 아닌 경우, isReady 값에 따라 색상 결정
    if (isReady != null) {
      return isReady! ? AppColors.p_7_base : AppColors.g_2;
    }
    // isReady가 null인 경우, 기본 색상으로 설정
    return AppColors.p_7_base;
  }
}
