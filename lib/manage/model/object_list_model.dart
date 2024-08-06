class ObjectListModel {
  final int userId;
  final int locationId;
  final double longitude;
  final String placeName;
  final double latitude;
  final String objectName;
  final String imageUrl;

  ObjectListModel.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as int,
        locationId = json['id'] as int,
        longitude = json['longitude'] as double,
        placeName = json['place_name'] ?? '',
        latitude = json['latitude'] as double,
        objectName = json['object_name'] ?? '',
        imageUrl = json['image_url'] ?? '';

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'id': locationId,
        'longitude': longitude,
        'place_name': placeName,
        'latitude': latitude,
        'object_name': objectName,
        'image_url': imageUrl,
      };
}
