import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg4RestRoom extends StatefulWidget {
  final VoidCallback onNavigateForward;

  const MovementReg4RestRoom({
    super.key,
    required this.onNavigateForward,
  });

  @override
  State<MovementReg4RestRoom> createState() => _MovementReg4RestRoomState();
}

class _MovementReg4RestRoomState extends State<MovementReg4RestRoom> {
  int selectedIndex = 0;
  int selectedFloorIndex = 0;

  void switchAccesible(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void switchFloor(int index) {
    setState(() {
      selectedFloorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v64,
              Text(
                '해당 장소에\n장애인 화장실이 있나요?',
                style: AppTextStyles.B_24.copyWith(color: AppColors.g_10),
              ),
              Gaps.v40,
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.p_1,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: AppIcon.restroom,
                ),
              ),
              Gaps.v40,
              AccesibleButton(
                thisText: '있음',
                thisIndex: 1,
                thisFunction: () => switchAccesible(1),
                selectedIndex: selectedIndex,
              ),
              Gaps.v8,
              AccesibleButton(
                thisText: '없음',
                thisIndex: 2,
                thisFunction: () => switchAccesible(2),
                selectedIndex: selectedIndex,
              ),
              if (selectedIndex == 1) ...[
                Gaps.v40,
                Text('몇층에 있었나요?',
                    style: AppTextStyles.B_18.copyWith(color: AppColors.g_10)),
                Gaps.v16,
                Row(
                  children: [
                    ChipsButton(
                      thisIndex: 1,
                      selectedIndex: selectedFloorIndex,
                      thisText: '1-2층',
                      thisTap: () => switchFloor(1),
                    ),
                    Gaps.h10,
                    ChipsButton(
                      thisIndex: 2,
                      selectedIndex: selectedFloorIndex,
                      thisText: '3-4층',
                      thisTap: () => switchFloor(2),
                    ),
                    Gaps.h10,
                    ChipsButton(
                      thisIndex: 3,
                      selectedIndex: selectedFloorIndex,
                      thisText: '5층 이상',
                      thisTap: () => switchFloor(3),
                    ),
                  ],
                ),
              ]
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: widget.onNavigateForward,
                  child: Ink(
                      height: 36,
                      width: 68,
                      color: AppColors.s_w,
                      child: Center(
                          child: Text(
                        '건너뛰기',
                        style:
                            AppTextStyles.B_14.copyWith(color: AppColors.g_5),
                      ))),
                ),
                Gaps.v13,
                NextButton(
                  thisText: '다음으로',
                  isReady: selectedIndex != 0,
                  thisTap: widget.onNavigateForward,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
