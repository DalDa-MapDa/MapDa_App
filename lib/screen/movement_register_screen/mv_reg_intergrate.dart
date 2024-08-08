import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';

class MovementRegIntergrate extends StatefulWidget {
  const MovementRegIntergrate({super.key});

  @override
  State<MovementRegIntergrate> createState() => _MovementRegIntergrateState();
}

class _MovementRegIntergrateState extends State<MovementRegIntergrate> {
  int _currentIndex = 0; // 현재 인덱스

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
                      onNavigateForward: () => switchScreen(1)),
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
