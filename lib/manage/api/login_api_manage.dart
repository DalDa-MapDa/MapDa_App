import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginApiManage {
  static const String BaseUrl = 'https://api.mapda.site';

  // 애플 로그인 메소드
  static Future<void> loginWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final identityToken = appleCredential.identityToken;
      final authorizationCode = appleCredential.authorizationCode;

      final response = await http.post(
        Uri.parse('$BaseUrl/login/apple'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'identityToken': identityToken!,
          'authorizationCode': authorizationCode,
        }),
      );

      if (response.statusCode == 200) {
        print('로그인 성공: ${response.body}');
      } else {
        print('로그인 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('애플 로그인 중 오류 발생: $error');
    }
  }

  // 구글 로그인 메소드
  static Future<void> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // 로그인 취소됨
        print('로그인 취소됨');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null || accessToken == null) {
        print('토큰을 가져오는 데 실패했습니다.');
        return;
      }

      // 서버로 토큰 전송
      final response = await http.post(
        Uri.parse('$BaseUrl/login/google'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'idToken': idToken,
          'accessToken': accessToken,
        }),
      );

      if (response.statusCode == 200) {
        print('로그인 성공: ${response.body}');
      } else {
        print('로그인 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('구글 로그인 중 오류 발생: $error');
    }
  }

  // 카카오 로그인 메소드
  static Future<void> loginWithKakao() async {
    try {
      // Step 1: /login/kakao 라우트를 호출하여 사용자에게 카카오 로그인 페이지로 리다이렉트
      const kakaoLoginUrl = '$BaseUrl/login/kakao';
      if (await canLaunchUrl(Uri.parse(kakaoLoginUrl))) {
        await launchUrl(Uri.parse(kakaoLoginUrl));
      } else {
        throw 'Could not launch Kakao login URL';
      }

      // Step 2: 카카오 인증이 완료된 후, authCode를 가지고 서버로 요청
      // 이 부분은 사용자가 인증을 완료한 후, 서버로 전달받은 authCode를 전송해야 합니다.
      // 예시: /login/kakao/auth?code=<authCode>
      // 이 부분은 실제 카카오 인증이 완료된 후에 처리가 필요합니다.
      const authCode = '<KakaoAuthCode>'; // 카카오로부터 받은 인증 코드
      final response = await http.get(
        Uri.parse('$BaseUrl/login/kakao/auth?code=$authCode'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('카카오 로그인 성공: ${response.body}');
      } else {
        print('카카오 로그인 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('카카오 로그인 중 오류 발생: $error');
    }
  }
}
