import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/constants/manage/screen_mange.dart';
import 'package:mapda/manage/api/object_api_manage.dart';

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
  LocationData? currentLocation;
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _retrieveLocation();
    _convertImage();
    _textFieldController.addListener(_updateState); // 리스너 추가
  }

  @override
  void dispose() {
    _textFieldController.removeListener(_updateState); // 리스너 제거
    _textFieldController.dispose();
    super.dispose();
  }

  // 텍스트 필드 값 변경시 상태 업데이트를 위한 메소드
  void _updateState() {
    if (_textFieldController.text.isEmpty) {
      setState(() {
        isTextFieldEmpty = true;
      });
    } else {
      setState(() {
        isTextFieldEmpty = false;
      });
    }
  }

  // 업로드 가능 여부 확인
  bool isReadyToUpload() {
    return convertedJpeg != null &&
        currentLocation != null &&
        !isTextFieldEmpty;
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

      return convertedJpeg;
    } catch (e) {
      return null;
    }
  }

  // 위치 정보 가져오기
  void _retrieveLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
    currentLocation = await location.getLocation();
  }

  // TextField 내용을 지우는 함수
  void clearTextField() {
    _textFieldController.clear();
  }

  // 서버에 데이터 업로드
  void uploadDangerObject() async {
    if (!isReadyToUpload()) {
      return;
    } else if (isReadyToUpload()) {
      try {
        final response = await ObjectApiManage.postDangerObject(
          userID: 123,
          latitude: currentLocation!.latitude!,
          longitude: currentLocation!.longitude!,
          objectName: widget.thisObjectName,
          placeName: _textFieldController.text,
          imageData: convertedJpeg!,
        );
        final int newObjectId = response['id'];

        // IntergrateScreen으로 이동하고, 스낵바 표시
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => IntergrateScreen(
                      switchIndex: SwitchIndex.toZero,
                      newObjectId: newObjectId,
                    )),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('등록에 실패했습니다: $e')));
      }
    }
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
              CustomTextfield(
                textFieldController: _textFieldController,
                extraWidget: Row(
                  children: [
                    Gaps.h16,
                    GestureDetector(
                      onTap: clearTextField,
                      child: AppIcon.x_circle_24,
                    ),
                  ],
                ),
                hintText: '예시) 정문, 본관 뒤 길',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            NextButton(
              thisTap: uploadDangerObject,
              isReady: isReadyToUpload(),
              thisText: '등록하기',
            ),
          ],
        ),
      ),
    );
  }
}
