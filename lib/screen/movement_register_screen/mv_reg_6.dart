import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg6Ramp extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final Function(int) rampAccessible;

  const MovementReg6Ramp({
    super.key,
    required this.onNavigateForward,
    required this.rampAccessible,
  });

  @override
  State<MovementReg6Ramp> createState() => _MovementReg6RampState();
}

class _MovementReg6RampState extends State<MovementReg6Ramp> {
  int selectedIndex = 0;

  void switchAccesible(int index) {
    setState(() {
      selectedIndex = index;
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
                '해당 장소에\n경사로는 어떤가요?',
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
                  child: AppIcon.ramp,
                ),
              ),
              Gaps.v40,
              AccesibleButton(
                thisText: '높음',
                thisIndex: 1,
                thisFunction: () => switchAccesible(1),
                selectedIndex: selectedIndex,
              ),
              Gaps.v8,
              AccesibleButton(
                thisText: '낮음',
                thisIndex: 2,
                thisFunction: () => switchAccesible(2),
                selectedIndex: selectedIndex,
              ),
              Gaps.v8,
              AccesibleButton(
                thisText: '미설치 ',
                thisIndex: 3,
                thisFunction: () => switchAccesible(3),
                selectedIndex: selectedIndex,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    switchAccesible(0);
                    widget.onNavigateForward();
                  },
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
                  thisTap: () {
                    widget.onNavigateForward();
                    widget.rampAccessible(selectedIndex);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
