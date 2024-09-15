class PlaceListModel {
  final double latitude;
  final String createdAt;
  final int userId;
  final double longitude;
  final int restRoomExist;
  final int elevatorAccessible;
  final List<String> inDoorImageUrls;
  final int id;
  final String placeName;
  final int wheeleChairAccessible;
  final int restRoomFloor;
  final int rampAccessible;
  final List<String> outDoorImageUrls;

  PlaceListModel({
    required this.latitude,
    required this.createdAt,
    required this.userId,
    required this.longitude,
    required this.restRoomExist,
    required this.elevatorAccessible,
    required this.inDoorImageUrls,
    required this.id,
    required this.placeName,
    required this.wheeleChairAccessible,
    required this.restRoomFloor,
    required this.rampAccessible,
    required this.outDoorImageUrls,
  });

  factory PlaceListModel.fromJson(Map<String, dynamic> json) {
    return PlaceListModel(
      latitude: json['latitude'],
      createdAt: json['created_at'],
      userId: json['user_id'],
      longitude: json['longitude'],
      restRoomExist: json['rest_room_exist'],
      elevatorAccessible: json['elevator_accessible'],
      inDoorImageUrls: List<String>.from(json['indoor_images']),
      id: json['id'],
      placeName: json['place_name'],
      wheeleChairAccessible: json['wheele_chait_accessible'],
      restRoomFloor: json['rest_room_floor'],
      rampAccessible: json['ramp_accessible'],
      outDoorImageUrls: List<String>.from(json['outdoor_images']),
    );
  }
}
