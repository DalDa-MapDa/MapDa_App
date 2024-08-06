import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mapda/constants/manage/model_manage.dart';
import 'package:http_parser/http_parser.dart'; // http_parser 패키지 임포트

class ObjectApiManage {
  static String baseUrl = "http://10.0.2.2:8000";
  static final Dio _dio = Dio();

  // 위험 물체 리스트 GET 메소드
  static Future<List<ObjectListModel>> getDangerObjectList() async {
    final response = await http.get(Uri.parse('$baseUrl/get_object_list'));

    if (response.statusCode == 200) {
      // UTF-8로 디코딩된 데이터를 가져옴
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => ObjectListModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load object list');
    }
  }

  // 위험 물체 등록 POST 메소드
  static Future<void> postDangerObject({
    required int userID,
    required double latitude,
    required double longitude,
    required String objectName,
    required String placeName,
    required Uint8List imageData,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'userID': userID,
        'latitude': latitude,
        'longitude': longitude,
        'objectName': objectName,
        'placeName': placeName,
        'imageData': MultipartFile.fromBytes(
          imageData,
          filename: 'upload.jpg', // 파일명 지정
          contentType: MediaType('image', 'jpeg'), // 올바른 MediaType 객체 사용
        ),
      });

      final response = await _dio.post('$baseUrl/register', data: formData);

      if (response.statusCode == 200) {
        print('Upload successful');
      } else {
        print('Failed to upload. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while uploading: $e');
      throw Exception('Failed to upload object');
    }
  }
}
