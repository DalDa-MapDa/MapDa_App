import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapda/constants/definition/constants.dart';

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
                        thisTap: () => LoginApiManage.loginWithGoogle(),
                      ),
                      Gaps.v10,
                      LoginButton(
                        thisColor: AppColors.s_b,
                        thisText: '애플로 계속하기',
                        thisTextColor: AppColors.s_w,
                        thisIcon: AppIcon.apple_logo_white,
                        thisTap: () => LoginApiManage.loginWithApple(),
                      ),
                      Gaps.v10,
                      LoginButton(
                        thisColor: const Color(0xffFEE500),
                        thisText: '카카오 로그인',
                        thisTextColor: AppColors.s_b,
                        thisIcon: AppIcon.kakao_logo,
                        thisTap: () => LoginApiManage.loginWithKakao(),
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
