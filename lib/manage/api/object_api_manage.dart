// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mapda/constants/manage/model_manage.dart';
import 'package:http_parser/http_parser.dart'; // http_parser 패키지 임포트

class ObjectApiManage {
  // static String baseUrl = "http://10.0.2.2:8000";
  static String baseUrl = "https://api.mapda.site";
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

  // 이동 데이터 등록 POST 메소드
  static Future<Map<String, dynamic>> postMovingData({
    required int userID,
    required String placeName,
    required Map<String, double> selectedLocation,
    required int wheeleChaitAccessible,
    required int restRoomExist,
    required int restRoomFloor,
    required int elevatorAccessible,
    required int rampAccessible,
    List<Uint8List>? inDoorImages,
    List<Uint8List>? outDoorImages,
  }) async {
    try {
      // FormData 생성
      FormData formData = FormData.fromMap({
        'userID': userID,
        'placeName': placeName,
        'selectedLocation': jsonEncode(selectedLocation),
        'wheeleChaitAccessible': wheeleChaitAccessible,
        'restRoomExist': restRoomExist,
        'restRoomFloor': restRoomFloor,
        'elevatorAccessible': elevatorAccessible,
        'rampAccessible': rampAccessible,
      });

      if (inDoorImages != null) {
        for (var i = 0; i < inDoorImages.length; i++) {
          formData.files.add(MapEntry(
            'inDoorImage',
            MultipartFile.fromBytes(
              inDoorImages[i],
              filename: 'in_door_image_$i.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          ));
        }
      }

      if (outDoorImages != null) {
        for (var i = 0; i < outDoorImages.length; i++) {
          formData.files.add(MapEntry(
            'outDoorImage',
            MultipartFile.fromBytes(
              outDoorImages[i],
              filename: 'out_door_image_$i.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          ));
        }
      }

      final response =
          await _dio.post('$baseUrl/register_moving_data', data: formData);

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
      throw Exception('Failed to upload moving data');
    }
  }

  // 장소 리스트 GET 메소드
  static Future<List<PlaceListModel>> getPlaceList() async {
    final response = await http.get(Uri.parse('$baseUrl/get_place_list'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => PlaceListModel.fromJson(item)).toList();
    } else {
      throw Exception('장소정보 로드 실패');
    }
  }
}
