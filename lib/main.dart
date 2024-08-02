// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/manage/screen_mange.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _naverMapInitailize();
  runApp(const MyApp());
}

Future<void> _naverMapInitailize() async {
  await NaverMapSdk.instance.initialize(
    clientId: 'piicuaz1z8',
    onAuthFailed: (e) => print('네이버 지도 인증 실패: $e'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManage.theme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // SplashScreen에서 시스템 네비게이션 바 색상 설정
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffFF5C5C), // 네비게이션 바 색상
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const IntergrateScreen(),
          ),
        );
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent, // 원래 색상으로 설정
        ));
      },
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
          child: Column(
            children: [
              Gaps.v286,
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
      ),
    );
  }
}
