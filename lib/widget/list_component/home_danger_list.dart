import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class HomeDangerList extends StatelessWidget {
  const HomeDangerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            color: AppColors.s_w,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 62,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.g_7,
                  borderRadius: BorderRadius.circular(6),
                )),
            Gaps.h24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '위험 물체',
                  style: AppTextStyles.B_16.copyWith(color: AppColors.g_11),
                ),
                Gaps.v8,
                Text('위험 물체가 감지되었습니다.',
                    style: AppTextStyles.R_14.copyWith(color: AppColors.g_6)),
              ],
            ),
          ],
        ));
  }
}
