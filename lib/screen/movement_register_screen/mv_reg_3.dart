import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg3Wheelchair extends StatefulWidget {
  final VoidCallback onNavigateForward;

  const MovementReg3Wheelchair({
    super.key,
    required this.onNavigateForward,
  });

  @override
  State<MovementReg3Wheelchair> createState() => _MovementReg3WheelchairState();
}

class _MovementReg3WheelchairState extends State<MovementReg3Wheelchair> {
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
                '해당 장소에\n휠체어 접근은 어떠한가요?',
                style: AppTextStyles.B_24.copyWith(color: AppColors.g_10),
              ),
              Gaps.v40,
              AccesibleButton(
                thisText: '쉬움',
                thisIndex: 1,
                thisFunction: () => switchAccesible(1),
                selectedIndex: selectedIndex,
              ),
              Gaps.v8,
              AccesibleButton(
                thisText: '불편함',
                thisIndex: 2,
                thisFunction: () => switchAccesible(2),
                selectedIndex: selectedIndex,
              ),
              Gaps.v8,
              AccesibleButton(
                thisText: '어려움',
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
            child: NextButton(
              thisText: '다음으로',
              isReady: selectedIndex != 0,
              thisTap: widget.onNavigateForward,
            ),
          )
        ],
      ),
    );
  }
}
