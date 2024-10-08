import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mapda/screen/object_register_screen/object_recognition/camera_settings.dart';
import 'package:mapda/screen/object_register_screen/object_recognition/classifier.dart';
import 'package:mapda/screen/object_register_screen/object_recognition/isolateutils.dart';
import 'package:mapda/screen/object_register_screen/object_recognition/recognition.dart';

//각 프레임을 추론에 전달하는 CameraView
class CameraView extends StatefulWidget {
  // 결과를 반환하기 위한 콜백 함수
  final Function(List<Recognition> recognitions) resultsCallback;
  // 추론 시간을 업데이트하기 위한 콜백 함수
  final Function(int elapsedTime) updateElapsedTimeCallback;
  // CameraView 생성자
  const CameraView(this.resultsCallback, this.updateElapsedTimeCallback,
      {super.key});
  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  // 사용 가능한 카메라 목록
  List<CameraDescription>? cameras;
  // 카메라 컨트롤러
  CameraController? cameraController;
  // 추론 중일 때 true
  bool? predicting;
  // Classifier 인스턴스
  Classifier? classifier;
  // IsolateUtils 인스턴스
  IsolateUtils? isolateUtils;
  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);
    // 새로운 Isolate를 생성
    isolateUtils = IsolateUtils();
    await isolateUtils?.start();
    // 카메라 초기화
    initializeCamera();
    // 모델 및 레이블을 로드하기 위해 Classifier 인스턴스 생성
    classifier = Classifier();
    // 초기에 predicting은 false로 설정
    predicting = false;
  }

  // 카메라를 초기화하고 cameraController를 설정
  void initializeCamera() async {
    cameras = await availableCameras();
    // cameras[0]은 후면 카메라
    cameraController =
        CameraController(cameras![1], ResolutionPreset.low, enableAudio: false);
    cameraController?.initialize().then((_) async {
      // onLatestImageAvailable 함수를 전달하여 각 프레임에 대한 인식을 수행
      await cameraController?.startImageStream(onLatestImageAvailable);
      // 현재 카메라의 미리보기의 크기
      Size? previewSize = cameraController?.value.previewSize;
      CameraSettings.inputImageSize = previewSize;
      // 해당 스마트폰의 화면의 크기
      Size screenSize = MediaQuery.of(context).size;
      CameraSettings.screenSize = screenSize;
      //프리뷰 프레임의 너비와 화면 너비 간의 비율
      CameraSettings.ratio = screenSize.width / (previewSize?.height ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 카메라가 초기화되지 않은 경우 빈 컨테이너 반환
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }
    // 카메라 프리뷰
    return AspectRatio(
      //카메라 프리뷰 화면의 가로 세로 비율
      aspectRatio: 1 / cameraController!.value.aspectRatio,
      child: CameraPreview(cameraController!),
    );
  }

  // 프레임마다 호출
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier?.interpreter != null && classifier?.labels != null) {
      // 이전 추론이 완료되지 않은 경우 반환
      if (predicting ?? false) {
        return;
      }
      setState(() {
        // 이전 추론 완료
        predicting = true;
      });
      //추론 시작 시간
      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;
      // 추론 Isolate에 전달할 데이터
      var isolateData = IsolateData(cameraImage,
          classifier?.interpreter?.address ?? 0, classifier?.labels ?? []);
      // 추론 결과 반환
      Map<String, dynamic> inferenceResults = await inference(isolateData);
      // 추론 시간 계산
      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;
      // 결과를 HomeView로 전달
      widget.resultsCallback(inferenceResults["recognitions"]);
      // 추론 시간 HomeView로 전달
      widget.updateElapsedTimeCallback(uiThreadInferenceElapsedTime);
      // 새로운 프레임을 허용하기 위해 predicting을 false로 설정
      setState(() {
        predicting = false;
      });
    }
  }

  // 다른 Isolate에서 추론을 실행
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils?.sendPort
        ?.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  // 앱이 일시 중지되거나 재개될 때 호출
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // 앱이 일시 중지 상태로 들어가면 카메라 스트림 중지
      cameraController?.stopImageStream();
    } else if (state == AppLifecycleState.resumed) {
      // 앱이 다시 활성화되면 카메라 스트림 재개
      if (cameraController != null && mounted) {
        cameraController?.startImageStream(onLatestImageAvailable);
      }
    }
  }

  @override
  // 앱이 화면에서 사라질 때 호출
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }
}
