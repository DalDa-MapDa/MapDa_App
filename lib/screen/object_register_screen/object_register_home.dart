import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapda/constants/definition/gaps.dart';

class ObjectRegisterHome extends StatefulWidget {
  final String thisObjectName;
  final ui.Image image;

  const ObjectRegisterHome({
    super.key,
    required this.thisObjectName,
    required this.image,
  });

  @override
  State<ObjectRegisterHome> createState() => _ObjectRegisterHomeState();
}

class _ObjectRegisterHomeState extends State<ObjectRegisterHome> {
  String _location = '위치를 가져오는 중...';
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _retrieveLocation();
    print('이미지 포맷: ${widget.image}');
  }

  void _retrieveLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      _location = "위도: ${locationData.latitude}, 경도: ${locationData.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v30,
            SizedBox(
              height: 400,
              width: 280,
              child: CustomPaint(
                painter: ImagePainter(widget.image),
              ),
            ),
            Text('사물명: ${widget.thisObjectName}'),
            Text('위치: $_location'),
          ],
        ),
      ),
    );
  }
}

//받아온 이미지 데이터 처리
class ImagePainter extends CustomPainter {
  final ui.Image image;
  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    // 캔버스 크기에 맞춰 이미지를 스케일 조정
    double scale = size.width / image.width;
    Rect dst = Rect.fromLTWH(0, 0, image.width * scale, image.height * scale);
    // 이미지를 캔버스에 맞춰 그리기
    canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        dst,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
