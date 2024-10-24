import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'dart:convert';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapda/constants/definition/constants.dart';

class LoginApiManage {
  static const String BaseUrl = 'https://api.mapda.site';

  //응답 받은 토큰 저장 메소드
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await UserTokenManage().setAccessToken(accessToken);
    await UserTokenManage().setRefreshToken(refreshToken);
  }

  // 애플 로그인 메소드
  static Future<int?> loginWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.dalda.mapda',
          redirectUri: Uri.parse('$BaseUrl/login/apple'),
        ),
      );

      final identityToken = appleCredential.identityToken;
      final authorizationCode = appleCredential.authorizationCode;
      final userEmail = appleCredential.email;
      final userName =
          "${appleCredential.familyName}${appleCredential.givenName}";

      final response = await http.post(
        Uri.parse('$BaseUrl/login/apple'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'identityToken': identityToken!,
          'authorizationCode': authorizationCode,
          'userEmail': userEmail ?? '',
          'userName': userName,
        }),
      );

      if (200 <= response.statusCode && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        await saveTokens(
            responseData['access_token'], responseData['refresh_token']);
      }
      return response.statusCode;
    } catch (error) {
      return null;
    }
  }

  // 구글 로그인 메소드
  static Future<int?> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        clientId: Platform.isAndroid
            ? '734591230931-tqcf13jecei0qbf4odq73m0d9jppo1pl.apps.googleusercontent.com'
            : null, // iOS에서는 clientId를 생략
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null; // 로그인 취소 시 null 반환
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null || accessToken == null) {
        return null; // 토큰 실패 시 null 반환
      }

      // 서버로 토큰 전송 및 응답 상태 코드 반환
      return await _sendTokensToServer(idToken, accessToken);
    } catch (error) {
      return null; // 오류 발생 시 null 반환
    }
  }

  // 서버로 토큰 전송 메소드
  static Future<int?> _sendTokensToServer(
      String idToken, String accessToken) async {
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

    if (200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      await saveTokens(
          responseData['access_token'], responseData['refresh_token']);
    }

    return response.statusCode; // 상태 코드 반환
  }

  // 카카오 로그인 메소드
  static Future<int?> loginWithKakao() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }

      // 로그인 성공 후 사용자 정보 서버로 전송
      return await _getKakaoUserInfo();
    } catch (error) {
      return null;
    }
  }

  // 카카오 사용자 정보 가져오기 및 서버로 전송 메소드
  static Future<int?> _getKakaoUserInfo() async {
    try {
      User user = await UserApi.instance.me();

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
          'isProfileImageDefault': user.kakaoAccount?.profile?.isDefaultImage,
          'thumbnailImage': user.kakaoAccount?.profile?.thumbnailImageUrl,
          'connectedAt': user.connectedAt.toString(),
        }),
      );

      if (200 <= response.statusCode && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        await saveTokens(
            responseData['access_token'], responseData['refresh_token']);
      }
      return response.statusCode;
    } catch (error) {
      return null;
    }
  }
}
