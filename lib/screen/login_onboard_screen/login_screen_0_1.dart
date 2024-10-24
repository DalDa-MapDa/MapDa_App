import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapda/constants/definition/constants.dart';

//로그인 타입 지정
enum LoginType {
  GOOGLE,
  APPLE,
  KAKAO,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    // LoginScreen에서 시스템 네비게이션 바 색상 설정
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffFF5C5C), // 네비게이션 바 색상
      ),
    );
  }

  Future<void> loginMethod(LoginType loginType) async {
    int? statusCode; // statusCode 변수 선언

    // 로그인 메소드 호출
    switch (loginType) {
      case LoginType.GOOGLE:
        statusCode = await LoginApiManage.loginWithGoogle();
        break;
      case LoginType.APPLE:
        statusCode = await LoginApiManage.loginWithApple();
        break;
      case LoginType.KAKAO:
        statusCode = await LoginApiManage.loginWithKakao();
        break;
    }

    // 응답 상태 코드에 따른 동작
    if (statusCode == 200) {
      print('로그인 성공');
    } else if (statusCode == 201 || statusCode == 202) {
      print('특정 동작 수행: 서버 응답 코드 $statusCode');
      // 여기에 원하는 동작 추가
      // 예: Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('로그인 실패 또는 다른 응답 코드: $statusCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFF8D8D),
              Color(0xffFF5C5C),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 310, bottom: 360),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon.splash_logo,
                    Gaps.v20,
                    const Text(
                      '맵다',
                      style: TextStyle(
                          fontFamily: 'yangjin',
                          fontSize: 40,
                          color: AppColors.s_w,
                          fontWeight: FontWeight.bold,
                          height: 44 / 40),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      LoginButton(
                        thisColor: AppColors.s_w,
                        thisText: 'Sign in with Google',
                        thisTextColor: const Color(0xff3C4043),
                        thisIcon: AppIcon.google_logo,
                        thisTap: () => loginMethod(LoginType.GOOGLE), // 구글 로그인
                      ),
                      Gaps.v10,
                      LoginButton(
                        thisColor: AppColors.s_b,
                        thisText: '애플로 계속하기',
                        thisTextColor: const Color.fromRGBO(255, 255, 255, 1),
                        thisIcon: AppIcon.apple_logo_white,
                        thisTap: () => loginMethod(LoginType.APPLE), // 애플 로그인
                      ),
                      Gaps.v10,
                      LoginButton(
                        thisColor: const Color(0xffFEE500),
                        thisText: '카카오 로그인',
                        thisTextColor: AppColors.s_b,
                        thisIcon: AppIcon.kakao_logo,
                        thisTap: () => loginMethod(LoginType.KAKAO), // 카카오 로그인
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
