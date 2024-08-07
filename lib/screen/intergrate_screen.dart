import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';

enum SwitchIndex {
  none,
  toZero,
  toOne,
  toTwo,
  toThree,
}

class IntergrateScreen extends StatefulWidget {
  final SwitchIndex switchIndex;
  final int? newObjectId;

  const IntergrateScreen({
    super.key,
    this.switchIndex = SwitchIndex.none,
    this.newObjectId,
  });

  // 외부에서 접근 가능한 함수를 정의_교외지원사업 탭
  static void setSelectedIndexToZero(BuildContext context) {
    final state = context.findAncestorStateOfType<IntergrateScreenState>();
    state?.setSelectedIndexToZero();
  }

  // 외부에서 접근 가능한 함수를 정의_교내지원사업 탭
  static void setSelectedIndexToOne(BuildContext context) {
    final state = context.findAncestorStateOfType<IntergrateScreenState>();
    state?.setSelectedIndexToOne();
  }

  @override
  State<IntergrateScreen> createState() => IntergrateScreenState();
}

class IntergrateScreenState extends State<IntergrateScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.newObjectId != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => showCompletionSnackbar(widget.newObjectId!),
      );
    }

    switch (widget.switchIndex) {
      case SwitchIndex.none:
        // 초기 설정이 필요 없는 경우
        break;
      case SwitchIndex.toZero:
        _selectedIndex = 0;
        break;
      case SwitchIndex.toOne:
        _selectedIndex = 1;
        break;
      case SwitchIndex.toTwo:
        _selectedIndex = 2;
        break;
      case SwitchIndex.toThree:
        _selectedIndex = 3;
        break;
    }
  }

  // 스낵바를 동적으로 표시하는 메서드
  void showCompletionSnackbar(int objectId) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.create(
      message: "위험물체로 등록 완료되었습니다",
      actionLabel: "보러가기",
      onAction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificObjectScreen(
              objectId: objectId,
            ),
          ),
        );
      },
    ));
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setSelectedIndexToZero() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  void setSelectedIndexToOne() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const MainHome();
      case 1:
        return const CameraHomeScreen();
      case 2:
        return const CameraHomeScreen();
      case 3:
        return const CameraHomeScreen();
      default:
        return const CameraHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -1), // 그림자의 위치 조정
            ),
          ],
        ),
        child: BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 각 탭 구성
              GnbTap(
                text: '홈',
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
                selecetedIcon: AppIcon.gnb_map_24_actived,
                unselecetedIcon: AppIcon.gnb_map_24_inactived,
              ),
              GnbTap(
                text: '객체인식',
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
                selecetedIcon: AppIcon.gnb_camera_24_actived,
                unselecetedIcon: AppIcon.gnb_camera_24_inactived,
              ),
              GnbTap(
                text: '캠퍼스',
                isSelected: _selectedIndex == 2,
                onTap: () => _onTap(2),
                selectedIndex: _selectedIndex,
                selecetedIcon: AppIcon.gnb_flag_24_actived,
                unselecetedIcon: AppIcon.gnb_flag_24_inactived,
              ),
              GnbTap(
                text: '마이',
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
                selecetedIcon: AppIcon.gnb_userprofile_24_actived,
                unselecetedIcon: AppIcon.gnb_userprofile_24_inactived,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
