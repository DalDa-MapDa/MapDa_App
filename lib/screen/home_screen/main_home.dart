import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/constants.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  Widget _buildNaverMap() {
    //네이버 지도 위젯 생성
    return NaverMap(
      options: const NaverMapViewOptions(
        indoorEnable: true, // 실내 맵 사용 가능 여부 설정
        locationButtonEnable: false, // 위치 버튼 표시 여부 설정
        consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
      ),
      onMapReady: (controller) async {
        // 지도 준비 완료 시 호출되는 콜백 함수
        mapControllerCompleter
            .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
      },
    );
  }

  Widget searchTextFormField() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: '강의동, 화장실, 주차장 정보 검색',
          hintStyle: AppTextStyles.R_14.copyWith(color: AppColors.g_5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildNaverMap(),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.fromLTRB(24, 54, 24, 0),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.s_b,
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ],
                color: AppColors.s_w,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.h16,
                  AppIcon.search_24,
                  Gaps.h16,
                  searchTextFormField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
