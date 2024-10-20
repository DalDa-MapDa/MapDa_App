import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
}
