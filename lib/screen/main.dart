import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapda/constants/color_table.dart';
import 'package:mapda/constants/gaps.dart';
import 'package:mapda/constants/icon_table.dart';
import 'package:mapda/screen/object_recognition/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
            builder: (context) => const HomeView(),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
              const Spacer(),
              const Text(
                '현대오토에버와 서울사회복지공동모금회가\n지원하는 배리어프리 앱 개발 콘테스트의 출품작입니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'pretendard',
                  fontSize: 10,
                  color: AppColors.s_w,
                  height: 14 / 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v48,
            ],
          ),
        ),
      ),
    );
  }
}
