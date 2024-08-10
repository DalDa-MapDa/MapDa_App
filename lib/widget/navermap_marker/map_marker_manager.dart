import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/model_manage.dart';

class MapMarkerManager {
  final BuildContext context;
  final NaverMapController naverMapController;

  MapMarkerManager(this.context, this.naverMapController);

  Future<void> addMarkersToMapForObject(
      List<ObjectListModel> objectList) async {
    for (var place in objectList) {
      final NOverlayImage objectMarker = await NOverlayImage.fromWidget(
        widget: SizedBox(
          width: 46,
          height: 65,
          child: Stack(
            children: [
              Container(
                width: 42,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.s_w, width: 3),
                ),
                child: Image.network(
                  place.imageUrl, // 네트워크 이미지 표시
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AppIcon.marker_red_24,
              ),
            ],
          ),
        ),
        size: const Size(46, 65),
        context: context,
      );

      final marker = NMarker(
        id: place.placeName,
        position: NLatLng(place.latitude, place.longitude),
        icon: objectMarker,
      );

      marker.setOnTapListener((NMarker marker) {
        print('Tapped marker ID: ${marker.info.id}');
      });

      naverMapController.addOverlay(marker);
    }
  }

  Future<void> addMarkersToMapForPlace(List<PlaceListModel> placeList) async {
    for (var place in placeList) {
      final NOverlayImage placeMarker = await NOverlayImage.fromWidget(
        widget: AppIcon.marker_blue_24,
        size: const Size(24, 24),
        context: context,
      );

      final marker = NMarker(
        id: place.placeName,
        position: NLatLng(place.latitude, place.longitude),
        icon: placeMarker,
      );

      marker.setOnTapListener((NMarker marker) {
        print('Tapped marker ID: ${marker.info.id}');
      });

      naverMapController.addOverlay(marker);
    }
  }
}
