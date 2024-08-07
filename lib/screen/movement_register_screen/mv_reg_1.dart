import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg1PlaceName extends StatefulWidget {
  final VoidCallback onNavigateForward;

  const MovementReg1PlaceName({
    super.key,
    required this.onNavigateForward,
  });

  @override
  State<MovementReg1PlaceName> createState() => _MovementReg1PlaceNameState();
}

class _MovementReg1PlaceNameState extends State<MovementReg1PlaceName> {
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v64,
                  Text(
                    '이동 정보를 등록할\n장소 명을 입력해 주세요',
                    style: AppTextStyles.B_24.copyWith(color: AppColors.g_10),
                  ),
                  Gaps.v52,
                  CustomTextfield(
                    textFieldController: textFieldController,
                    hintText: '예시) 본관 입구, 본관 사이 구름다리',
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 40,
          left: 24,
          right: 24,
          child: NextButton(
            thisText: '다음으로',
            isReady: textFieldController.text.isNotEmpty,
            thisTap: widget.onNavigateForward,
          ),
        ),
      ],
    );
  }
}
