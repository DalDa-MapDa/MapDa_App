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
    setState(() {}); // 필요한 경우 추가 상태 업데이트 로직 포함
  }

  // 업로드 가능 여부 확인
  bool isReadyToUpload() {
    return convertedJpeg != null &&
        currentLocation != null &&
        _textFieldController.text.isNotEmpty;
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
  Future<void> uploadDangerObject() async {
    if (!isReadyToUpload()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지 변환을 기다리거나 위치 정보를 가져오세요.')));
      return;
    }

    try {
      // 서버에 데이터를 업로드하고 응답에서 ID를 추출
      final response = await ObjectApiManage.postDangerObject(
        userID: 123, // 예시 사용자 ID
        latitude: currentLocation!.latitude!,
        longitude: currentLocation!.longitude!,
        objectName: widget.thisObjectName,
        placeName: _textFieldController.text,
        imageData: convertedJpeg!,
      );

      // 응답 데이터에서 새로운 객체의 ID를 추출
      final int newObjectId = response['id'];

      // 스낵바를 통해 사용자에게 등록 완료 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.create(
        message: "위험물체로 등록 완료되었습니다",
        actionLabel: "보러가기",
        onAction: () {
          // '보러가기' 클릭 시, SpecificObjectScreen으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecificObjectScreen(
                objectId: newObjectId, // 전달할 ID
              ),
            ),
          );
        },
      ));

      // 모든 이전 라우트를 제거하고 새로운 화면으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const IntergrateScreen(
                  switchIndex: SwitchIndex.toZero,
                )),
        (Route<dynamic> route) => false, // 모든 이전 라우트 제거
      );
    } catch (e) {
      // 예외 발생 시 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('등록에 실패했습니다: $e')),
      );
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
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                isReadyToUpload() ? uploadDangerObject() : null;
              },
              child: Ink(
                height: 48,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isReadyToUpload() ? AppColors.p_7_base : AppColors.g_2,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    '등록 완료',
                    style: AppTextStyles.B_14.copyWith(color: AppColors.s_w),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
