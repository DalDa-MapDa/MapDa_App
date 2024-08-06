// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class CameraHomeScreen extends StatefulWidget {
  const CameraHomeScreen({super.key});

  @override
  State<CameraHomeScreen> createState() => _CameraHomeScreenState();
}

class _CameraHomeScreenState extends State<CameraHomeScreen> {
  final GlobalKey _cameraViewKey = GlobalKey(); // 스크린샷을 위한 키 추가

  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  int totalElapsedTime = 0;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //카메라 작동 중지를 위한 플래그
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.s_w,
        title: const Text(
          '위험 물체 인식',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.s_b, fontSize: 15),
        ),
      ),
      body: Stack(
        children: [
          if (!isRegistering)
            RepaintBoundary(
              key: _cameraViewKey,
              child: CameraView(resultsCallback, updateElapsedTimeCallback),
            ),
          boundingBoxes(results),
        ],
      ),
    );
  }

  // 스크린샷 캡처 함수
  Future<ui.Image> captureCameraView() async {
    RenderRepaintBoundary boundary = _cameraViewKey.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }

  // 사물을 탭할 때의 함수
  void _thisObjectTap({required String thisObjectName}) async {
    setState(() {
      isRegistering = true; // 카메라 작동 중지
    });
    ui.Image image = await captureCameraView(); // 스크린샷 캡처
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ObjectRegisterHome(
          thisObjectName: thisObjectName,
          image: image, // 스크린샷 이미지를 전달
        ),
      ),
    ).then((_) {
      setState(() {
        isRegistering = false; // 카메라 작동 재개
      });
    });
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map(
            (e) => BoxWidget(
              result: e,
              thisObjectTap: () =>
                  _thisObjectTap(thisObjectName: results[0].label!),
            ),
          )
          .toList(),
    );
  }

  Widget resultsList(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 20,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${(index + 1)}. 객체명: ${results[index].label}',
                      style: const TextStyle(fontSize: 13)),
                  Text(
                      '예츨확률: ${(results[index].score! * 100).toStringAsFixed(1)} %',
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
    });
  }

  void updateElapsedTimeCallback(int elapsedTime) {
    setState(() {
      totalElapsedTime = elapsedTime;
    });
  }
}

/// Row for one Stats field
Padding statsRow(left, right) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(left), Text(right)],
    ),
  );
}
