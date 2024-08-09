import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg2Location extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final Function(Map<String, double>) locationData;

  const MovementReg2Location({
    super.key,
    required this.onNavigateForward,
    required this.locationData,
  });

  @override
  State<MovementReg2Location> createState() => _MovementReg2LocationState();
}

class _MovementReg2LocationState extends State<MovementReg2Location> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  NMarker? currentMarker; // 현재 표시된 마커를 저장할 변수
  Map<String, double> tappedLocation = {};
  Future<NOverlayImage>? overlayImageFuture; // 미리 생성할 마커 이미지

  @override
  void initState() {
    overlayImageFuture = _createOverlayImage(); // 마커 이미지를 미리 생성
    super.initState();
  }

  @override
  void didChangeDependencies() {
    overlayImageFuture = _createOverlayImage(); // 마커 이미지를 미리 생성
    super.didChangeDependencies();
  }

  Future<NOverlayImage> _createOverlayImage() async {
    return await NOverlayImage.fromWidget(
      widget: AppIcon.marker_blue_24,
      size: const Size(56, 56),
      context: context,
    );
  }

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
          target: NLatLng(37.5802, 126.923),
          zoom: 17,
        ), // 카메라 초기 위치 설정
      ),
      onMapTapped: (point, latLng) =>
          tapLocation(longitude: latLng.longitude, latitude: latLng.latitude),
      onMapReady: (naverMapController) async {
        mapControllerCompleter
            .complete(naverMapController); // Completer에 지도 컨트롤러 완료 신호 전송
      },
    );
  }

  Future<void> tapLocation(
      {required double longitude, required double latitude}) async {
    setState(() {
      tappedLocation = {
        'longitude': longitude,
        'latitude': latitude,
      };
    });

    final controller = await mapControllerCompleter.future;
    final overlayImage = await overlayImageFuture!; // 미리 생성한 마커 이미지 사용

    final marker = NMarker(
      id: 'selected_location',
      position: NLatLng(latitude, longitude),
      icon: overlayImage,
    );

    controller.addOverlay(marker);
    setState(() {
      currentMarker = marker;
    });
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
          ),
        ),
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
              ),
            ),
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
                  isReady: tappedLocation.isNotEmpty,
                  thisTap: () {
                    widget.onNavigateForward();
                    widget.locationData(tappedLocation);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
