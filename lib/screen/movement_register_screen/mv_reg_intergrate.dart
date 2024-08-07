import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';

class MovementRegIntergrate extends StatefulWidget {
  const MovementRegIntergrate({super.key});

  @override
  State<MovementRegIntergrate> createState() => _MovementRegIntergrateState();
}

class _MovementRegIntergrateState extends State<MovementRegIntergrate> {
  final PageController _pageController = PageController(); // 페이지 컨트롤러 생성

  void switchScreen(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  // 뒤로가기 버튼
  void navigateBackward() {
    if (_pageController.page == 0) {
      Navigator.pop(context);
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
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
            MovementRegState(
                thisState: _pageController.hasClients
                    ? _pageController.page!.round() + 1
                    : 1),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {});
                },
                children: <Widget>[
                  MovementReg1PlaceName(
                      onNavigateForward: () => switchScreen(1)),
                  MovementReg2Location(
                      onNavigateForward: () => switchScreen(2)),
                  const MovementReg3Wheelchair()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
