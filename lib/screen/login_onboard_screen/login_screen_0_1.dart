import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 인코딩을 위해 추가

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

  // 애플 로그인 메소드
  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // 애플 서버로부터 받은 토큰과 코드를 FastAPI 서버로 전송
      final identityToken = appleCredential.identityToken;
      final authorizationCode = appleCredential.authorizationCode;

      // FastAPI로 POST 요청 보내기
      final response = await http.post(
        Uri.parse('https://api.mapda.site/login/apple'), // FastAPI 서버 URL로 변경
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'identityToken': identityToken!,
          'authorizationCode': authorizationCode,
        }),
      );

      if (response.statusCode == 200) {
        print('로그인 성공');
      } else {
        print('로그인 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('애플 로그인 중 오류 발생: $error');
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
                        thisColor: AppColors.s_b,
                        thisText: '애플로 계속하기',
                        thisTextColor: AppColors.s_w,
                        thisIcon: AppIcon.apple_logo_white,
                        thisTap: () => signInWithApple(),
                      ),
                      Gaps.v10,
                      LoginButton(
                        thisColor: const Color(0xffFEE500),
                        thisText: '카카오 로그인',
                        thisTextColor: AppColors.s_b,
                        thisIcon: AppIcon.kakao_logo,
                        thisTap: () {},
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
