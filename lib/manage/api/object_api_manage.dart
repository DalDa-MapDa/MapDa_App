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

  // 특정 위험 물체 정보를 가져오는 GET 메소드 (http 사용)
  static Future<ObjectListModel> getSpecificObject({required int id}) async {
    final response =
        await http.get(Uri.parse('$baseUrl/get_specific_object/$id'));

    if (response.statusCode == 200) {
      // 응답 데이터를 UTF-8로 디코딩하여 처리
      var decodedData = utf8.decode(response.bodyBytes);
      var jsonData = jsonDecode(decodedData);

      // ObjectListModel로 파싱
      return ObjectListModel.fromJson(jsonData);
    } else {
      throw Exception(
          'Failed to load object data. Status code: ${response.statusCode}');
    }
  }

  // 위험 물체 등록 POST 메소드
  static Future<Map<String, dynamic>> postDangerObject({
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
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      final response = await _dio.post('$baseUrl/register', data: formData);

      if (response.statusCode == 200) {
        print('Upload successful, response: ${response.data}');
        return response.data; // 서버 응답 데이터 반환
      } else {
        print('Failed to upload. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to upload. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while uploading: $e');
      throw Exception('Failed to upload object');
    }
  }
}
