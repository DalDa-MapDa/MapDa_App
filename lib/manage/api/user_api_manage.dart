import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapda/constants/definition/constants.dart';

class UserTokenApiManage {
  // 헤더를 가져오는 메소드
  static Future<Map<String, String>> getHeaders() async {
    String? accessToken = await UserTokenManage.getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
  }

  static const String BaseUrl = 'https://api.mapda.site';

  // AccessToken 재발급
  static Future<void> refreshAccessToken() async {
    String thisUrl = '$BaseUrl/auth/refresh';
    String? refreshToken = await UserTokenManage.getRefreshToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    }

    try {
      final response = await http.post(
        Uri.parse(thisUrl),
        headers: headers,
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String newAccessToken = responseData['access_token'];
        await UserTokenManage().setAccessToken(newAccessToken);
      } else {
        throw Exception('Failed to refresh access token');
      }
    } catch (error) {
      throw Exception('Error refreshing access token: $error');
    }
  }
}
