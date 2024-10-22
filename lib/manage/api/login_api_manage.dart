import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
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

  // 카카오 로그인 메소드
  static Future<void> loginWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        await _getKakaoUserInfo(); // 로그인 성공 시 사용자 정보 서버에 전송
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          await _getKakaoUserInfo(); // 로그인 성공 시 사용자 정보 서버에 전송
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        await _getKakaoUserInfo(); // 로그인 성공 시 사용자 정보 서버에 전송
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  // 카카오 사용자 정보 가져오기 및 서버로 전송 메소드
  static Future<void> _getKakaoUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공\n모든 회원정보: $user');

      // 서버에 사용자 정보 전송
      final response = await http.post(
        Uri.parse('$BaseUrl/login/kakao'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': user.id.toString(),
          'nickname': user.kakaoAccount?.profile?.nickname,
          'email': user.kakaoAccount?.email,
          'profileImage': user.kakaoAccount?.profile?.profileImageUrl,
          'thumbnailImage': user.kakaoAccount?.profile?.thumbnailImageUrl,
          'connectedAt': user.connectedAt.toString(),
        }),
      );

      if (response.statusCode == 200) {
        print('서버에 사용자 정보 전송 성공: ${response.body}');
      } else {
        print('서버에 사용자 정보 전송 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('사용자 정보 요청 또는 서버 전송 실패 $error');
    }
  }
}
