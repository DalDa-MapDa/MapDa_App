import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color thisColor;
  final String thisText;
  final Color thisTextColor;
  final Widget thisIcon;
  final Function() thisTap;

  const LoginButton({
    super.key,
    required this.thisColor,
    required this.thisText,
    required this.thisIcon,
    required this.thisTextColor,
    required this.thisTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Material의 기본 색상은 투명
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: thisTap,
        splashColor: Colors.transparent, // splash 효과 제거

        child: Ink(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: thisColor, // 기본 버튼 색상
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 14,
                child: thisIcon,
              ),
              Text(
                thisText,
                style: TextStyle(
                  fontFamily: 'pretendard',
                  fontSize: 14,
                  color: thisTextColor,
                  fontWeight: FontWeight.w400,
                  height: 17 / 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
