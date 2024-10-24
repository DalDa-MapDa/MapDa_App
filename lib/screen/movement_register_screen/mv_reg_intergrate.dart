import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';

class MovementRegIntergrate extends StatefulWidget {
  const MovementRegIntergrate({super.key});

  @override
  State<MovementRegIntergrate> createState() => _MovementRegIntergrateState();
}

class _MovementRegIntergrateState extends State<MovementRegIntergrate> {
  int _currentIndex = 0; // 현재 인덱스

  //데이터 저장 변수
  String placeName = ''; // 장소 명 저장 변수
  Map<String, double> selectedLocation = {};
  int wheeleChaitAccessible = 0;
  int restRoomExist = 0;
  int restRoomFloor = 0;
  int elevatorAccessible = 0;
  int rampAccessible = 0;
  List<XFile> inDoorImage = [];
  List<XFile> outDoorImage = [];

  // 화면 전환 함수
  void switchScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 뒤로가기 버튼
  void navigateBackward() {
    if (_currentIndex == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _currentIndex--;
      });
    }
  }

  // 장소명 저장 함수
  void savePlaceName(String name) {
    setState(() {
      placeName = name;
    });
  }

  // 위치 저장 함수
  void saveLocation(Map<String, double> location) {
    setState(() {
      selectedLocation = location;
    });
  }

  // 휠체어 접근성 저장 함수
  void saveWheelchair(int value) {
    setState(() {
      wheeleChaitAccessible = value;
    });
  }

//장애인 화장실 저장 함수
  void saveRestRoom(Map<String, int> restRoomData) {
    setState(() {
      restRoomExist = restRoomData['restRoomExist'] ?? 0;
      restRoomFloor = restRoomData['restRoomFloor'] ?? 0;
    });
  }

  // 엘리베이터 저장 함수
  void saveElevator(int value) {
    setState(() {
      elevatorAccessible = value;
    });
  }

  // 경사로 저장 함수
  void saveRamp(int value) {
    setState(() {
      rampAccessible = value;
    });
  }

  // 이미지 저장 함수
  void saveImage(Map<String, dynamic> images) {
    setState(() {
      inDoorImage = images['inDoorImage'] ?? [];
      outDoorImage = images['outDoorImage'] ?? [];
    });
    uploadMovingObject();
  }

  //이미지 데이터 저장 및 모든 데이터 취합 함수
  void uploadMovingObject() async {
    try {
      // 이미지 데이터를 Uint8List로 변환
      List<Uint8List> inDoorImageBytes =
          await Future.wait(inDoorImage.map((image) => image.readAsBytes()));
      List<Uint8List> outDoorImageBytes =
          await Future.wait(outDoorImage.map((image) => image.readAsBytes()));

      // ObjectApiManage의 postMovingData 호출
      final response = await ObjectApiManage.postMovingData(
        userID: 1, // 실제 사용자 ID로 변경
        placeName: placeName,
        selectedLocation: selectedLocation,
        wheeleChaitAccessible: wheeleChaitAccessible,
        restRoomExist: restRoomExist,
        restRoomFloor: restRoomFloor,
        elevatorAccessible: elevatorAccessible,
        rampAccessible: rampAccessible,
        inDoorImages: inDoorImageBytes,
        outDoorImages: outDoorImageBytes,
      );

      print('업로드 성공: $response');
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.create(
          message: "위험물체로 등록 완료되었습니다",
          actionLabel: "보러가기",
          onAction: () {},
        ));
      }
    } catch (e) {
      print('업로드 실패: $e');
    }
  }

  // 상단 앱바
  AppBar regAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: navigateBackward,
        child: AppIcon.arrow_left_24,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppIcon.x_24,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: regAppBar(),
        body: Column(
          children: [
            MovementRegState(thisState: _currentIndex + 1),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: <Widget>[
                  MovementReg1PlaceName(
                    onNavigateForward: () => switchScreen(1),
                    onPlaceName: savePlaceName,
                  ),
                  MovementReg2Location(
                    onNavigateForward: () => switchScreen(2),
                    locationData: saveLocation,
                  ),
                  MovementReg3Wheelchair(
                    onNavigateForward: () => switchScreen(3),
                    wheelChairAccessible: saveWheelchair,
                  ),
                  MovementReg4RestRoom(
                    onNavigateForward: () => switchScreen(4),
                    restRoomExistAndFloor: saveRestRoom,
                  ),
                  MovementReg5Elevator(
                    onNavigateForward: () => switchScreen(5),
                    elevatorAccessible: saveElevator,
                  ),
                  MovementReg6Ramp(
                    onNavigateForward: () => switchScreen(6),
                    rampAccessible: saveRamp,
                  ),
                  MovementReg7Image(
                    saveImages: saveImage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
