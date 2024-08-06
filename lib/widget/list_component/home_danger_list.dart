import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class HomeDangerList extends StatelessWidget {
  final String objectName, objectLocationName, imageUrl;

  const HomeDangerList({
    super.key,
    required this.objectName,
    required this.objectLocationName,
    required this.imageUrl, // 이미지 URL을 받기 위한 필드 추가
  });

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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.withOpacity(0.3), // 로딩 중일 때 보여줄 배경색
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                width: 62,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Gaps.h24,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                objectName,
                style: AppTextStyles.B_16.copyWith(color: AppColors.g_11),
              ),
              Gaps.v8,
              Text(
                objectLocationName,
                style: AppTextStyles.R_14.copyWith(color: AppColors.g_6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
