import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/model_manage.dart';
import 'package:mapda/constants/manage/screen_mange.dart';
import 'package:mapda/manage/api/object_api_manage.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  int listItemCount = 20;
  List<ObjectListModel> objectList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchObjectList();
  }

  Future<void> fetchObjectList() async {
    try {
      List<ObjectListModel> objects =
          await ObjectApiManage.getDangerObjectList();
      setState(() {
        objectList = objects;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildNaverMap() {
    // 네이버 지도 위젯 생성
    return const NaverMap(
      options: NaverMapViewOptions(
        liteModeEnable: true,
        indoorEnable: true, // 실내 맵 사용 가능 여부 설정
        locationButtonEnable: false, // 위치 버튼 표시 여부 설정
        consumeSymbolTapEvents: true, // 심볼 탭 이벤트 소비 여부 설정
        logoMargin: EdgeInsets.only(bottom: 30, left: 24),
        logoAlign: NLogoAlign.leftBottom,
        logoClickEnable: false,
        initialCameraPosition: NCameraPosition(
            target: NLatLng(37.5802, 126.923), zoom: 17), //카메라 초기 위치 설정
        // extent: NLatLngBounds(
        //   southWest: NLatLng(37.578595, 126.921763),
        //   northEast: NLatLng(37.581663, 126.924718), // 지도 영역 설정
        // ),
      ),
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

  Widget placeRegisterButton() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MovementRegIntergrate()),
                );
              },
              child: Ink(
                width: 184,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.p_7_base,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon.plus_white_16,
                    Gaps.h8,
                    Text(
                      '이동 정보 등록하기',
                      style: AppTextStyles.button_B_14
                          .copyWith(color: AppColors.s_w),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gpsButton() {
    return Positioned(
      bottom: 100,
      left: 24,
      child: AppIcon.gps_40,
    );
  }

  Widget dangerListModal() {
    return DraggableScrollableSheet(
      snap: true,
      minChildSize: 0.1,
      maxChildSize: 0.85,
      initialChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.s_w,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v36,
                    Gaps.v4,
                    Row(
                      children: [
                        Gaps.h24,
                        Text('우리 캠퍼스 ',
                            style: AppTextStyles.B_18
                                .copyWith(color: AppColors.g_10)),
                        Text('신규 위험 안내',
                            style: AppTextStyles.B_18
                                .copyWith(color: AppColors.p_7_base)),
                        Gaps.h8,
                        SizedBox(
                          width: 16,
                          child: AppIcon.pin_red_24,
                        )
                      ],
                    ),
                    Gaps.v24,
                    ...List.generate(
                      objectList.length,
                      (index) => Column(
                        children: [
                          HomeDangerList(
                            objectName: objectList[index].objectName,
                            objectLocationName: objectList[index].placeName,
                            imageUrl: objectList[index].imageUrl,
                            objectId: objectList[index].objectId,
                          ),
                          if (index != objectList.length - 1) Gaps.v16,
                          if (index == objectList.length - 1) Gaps.v24,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.s_w,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 4,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.g_7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Stack(
          // Stack 위젯으로 레이어 분리
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: _buildNaverMap(),
            ),
            gpsButton(),
            placeRegisterButton(),
            Positioned(
              // 검색 창 위치 지정
              top: 54, // 검색창 위치를 위쪽으로 조절
              left: 24,
              right: 24,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 48,
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
                    AppIcon.search_24,
                    Gaps.h16,
                    searchTextFormField(),
                  ],
                ),
              ),
            ),
            dangerListModal(), // DraggableScrollableSheet는 Stack의 자식으로 배치
          ],
        ),
      ),
    );
  }
}
