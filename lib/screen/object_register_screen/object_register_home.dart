import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapda/constants/definition/constants.dart';

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
  Location location = Location();
  Uint8List? convertedJpeg;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _retrieveLocation();
    _convertImage();
  }

  // ui.Image를 JPEG으로 변환
  Future<void> _convertImage() async {
    Uint8List? jpeg = await convertUiImageToJpeg(widget.image);
    setState(() {
      convertedJpeg = jpeg;
    });
  }

  Future<Uint8List?> convertUiImageToJpeg(ui.Image image) async {
    try {
      // ui.Image를 ByteData로 변환
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.rawRgba);

      if (byteData == null) {
        return null;
      }

      // ByteData를 Uint8List로 변환
      Uint8List rgbaBytes = byteData.buffer.asUint8List();

      // Image 패키지로 이미지 생성
      int width = image.width;
      int height = image.height;
      img.Image convertedImage = img.Image.fromBytes(width, height, rgbaBytes,
          format: img.Format.rgba);

      // 이미지 데이터를 JPEG로 인코딩
      Uint8List convertedJpeg =
          Uint8List.fromList(img.encodeJpg(convertedImage));
      print('변환 이미지:$convertedJpeg');

      return convertedJpeg;
    } catch (e) {
      print('Error converting ui.Image to JPEG: $e');
      return null;
    }
  }

  // 위치 정보 가져오기
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
  }

  // TextField 내용을 지우는 함수
  void clearTextField() {
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v16,
              if (convertedJpeg != null)
                Align(
                  alignment: Alignment.center,
                  child: Image.memory(
                    convertedJpeg!,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                )
              else
                const CircularProgressIndicator(),
              Gaps.v42,
              Text('해당 장소 명을 입력해주세요',
                  style: AppTextStyles.B_14.copyWith(color: AppColors.g_10)),
              Gaps.v8,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.g_1,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textFieldController, // 컨트롤러 설정
                        decoration: const InputDecoration(
                          hintText: '장소 명',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Gaps.h16,
                    GestureDetector(
                      onTap: clearTextField, // clearTextField 호출
                      child: AppIcon.x_24,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.s_w,
        child: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.p_7_base,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  '등록 완료',
                  style: AppTextStyles.B_14.copyWith(color: AppColors.s_w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
