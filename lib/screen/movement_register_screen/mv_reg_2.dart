import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg2Location extends StatefulWidget {
  final VoidCallback onNavigateForward;

  const MovementReg2Location({
    super.key,
    required this.onNavigateForward,
  });

  @override
  State<MovementReg2Location> createState() => _MovementReg2LocationState();
}

class _MovementReg2LocationState extends State<MovementReg2Location> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  Widget _buildNaverMap() {
    // 네이버 지도 위젯 생성
    return NaverMap(
      options: const NaverMapViewOptions(
        liteModeEnable: true,
        indoorEnable: true, // 실내 맵 사용 가능 여부 설정
        locationButtonEnable: false, // 위치 버튼 표시 여부 설정
        consumeSymbolTapEvents: true, // 심볼 탭 이벤트 소비 여부 설정
        logoMargin: EdgeInsets.only(bottom: 30, left: 20),
        logoAlign: NLogoAlign.leftBottom,
        logoClickEnable: false,
        initialCameraPosition: NCameraPosition(
            target: NLatLng(37.5802, 126.923), zoom: 17), //카메라 초기 위치 설정
        extent: NLatLngBounds(
          southWest: NLatLng(37.578595, 126.921763),
          northEast: NLatLng(37.581663, 126.920718), // 지도 영역 설정
        ),
      ),
      onMapReady: (naverMapController) async {
        // 지도 준비 완료 시 호출되는 콜백 함수
        mapControllerCompleter
            .complete(naverMapController); // Completer에 지도 컨트롤러 완료 신호 전송
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildNaverMap(),
        Container(
            width: double.infinity,
            height: 48,
            color: AppColors.s_b.withOpacity(0.4),
            alignment: Alignment.center,
            child: Text(
              '지도를 움직여 위치를 지정하세요',
              style: AppTextStyles.B_14.copyWith(color: AppColors.s_w),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.s_w,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '해당 장소에 정보를 등록합니다',
                  style: AppTextStyles.B_18.copyWith(color: AppColors.g_10),
                ),
                Gaps.v24,
                NextButton(
                  thisText: '다음으로',
                  isReady: true,
                  thisTap: widget.onNavigateForward,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
