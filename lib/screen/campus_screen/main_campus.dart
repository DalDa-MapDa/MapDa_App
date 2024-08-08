import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/manage/data/test_timetable.dart';

class MainCampus extends StatelessWidget {
  const MainCampus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        centerTitle: false,
        title: Text(
          '캠퍼스',
          style: AppTextStyles.B_16.copyWith(color: AppColors.g_10),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Text(
                '캠퍼스 명',
                style: AppTextStyles.B_18.copyWith(color: AppColors.g_10),
              ),
              Gaps.v16,
              Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: AppColors.p_1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '내 강의 장소에 대한 정보를 공유하세요',
                        style:
                            AppTextStyles.B_16.copyWith(color: AppColors.g_10),
                      ),
                      Gaps.v8,
                      Text(
                        '배리어프리 캠퍼스를 만드는데 큰 힘이 될거에요',
                        style:
                            AppTextStyles.R_12.copyWith(color: AppColors.g_9),
                      ),
                      Gaps.v20,
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Ink(
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.p_7_base,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '모두에게 도움 주러 가기',
                                style: AppTextStyles.B_14
                                    .copyWith(color: AppColors.s_w),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Gaps.v32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 시간표',
                    style: AppTextStyles.B_18.copyWith(color: AppColors.g_10),
                  ),
                  AppIcon.plus_dark_16,
                ],
              ),
              Gaps.v16,
              TimetableWidget(selectedLectures: selectedLectures),
              // 여기서 시간표 위젯 추가-UI 수정 필요,
              Gaps.v32,
            ],
          ),
        ),
      ),
    );
  }
}
