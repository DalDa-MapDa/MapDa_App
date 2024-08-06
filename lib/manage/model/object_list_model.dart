class ObjectListModel {
  final int userId;
  final int objectId;
  final double longitude;
  final String placeName;
  final double latitude;
  final String objectName;
  final String imageUrl;
  final DateTime createdAt; // 새로 추가된 필드

  ObjectListModel.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as int,
        objectId = json['id'] as int,
        longitude = json['longitude'] as double,
        placeName = json['place_name'] ?? '',
        latitude = json['latitude'] as double,
        objectName = json['object_name'] ?? '',
        imageUrl = json['image_url'] ?? '',
        createdAt =
            DateTime.parse(json['created_at']); // JSON 문자열을 DateTime으로 파싱

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'id': objectId,
        'longitude': longitude,
        'place_name': placeName,
        'latitude': latitude,
        'object_name': objectName,
        'image_url': imageUrl,
        'created_at': createdAt.toIso8601String(), // DateTime을 ISO8601 문자열로 변환
      };
}
