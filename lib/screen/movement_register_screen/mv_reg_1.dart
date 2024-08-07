import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg1PlaceName extends StatefulWidget {
  const MovementReg1PlaceName({super.key});

  @override
  State<MovementReg1PlaceName> createState() => _MovementReg1PlaceNameState();
}

class _MovementReg1PlaceNameState extends State<MovementReg1PlaceName> {
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: const BackAppBarWithClose(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MovementRegState(thisState: 1),
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
                const SizedBox(height: 40), // 기본 여백
                Padding(
                  padding:
                      EdgeInsets.only(bottom: bottomInset), // 키보드 높이만큼 추가 여백
                  child: const NextButton(thisText: '다음으로'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
