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

  void savePlaceName(String name) {
    setState(() {
      placeName = name;
    });
    print('장소명: $placeName');
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
                      onNavigateForward: () => switchScreen(2)),
                  MovementReg3Wheelchair(
                      onNavigateForward: () => switchScreen(3)),
                  MovementReg4RestRoom(
                      onNavigateForward: () => switchScreen(4)),
                  MovementReg5Elevator(
                      onNavigateForward: () => switchScreen(5)),
                  MovementReg6Ramp(onNavigateForward: () => switchScreen(6)),
                  const MovementReg7Image(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
