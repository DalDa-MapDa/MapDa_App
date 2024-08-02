import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

Future<Uint8List> convertYUV420toImageByte(CameraImage image) async {
  try {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int? uvPixelStride = image.planes[1].bytesPerPixel;

    // 이미지 라이브러리 생성
    var img = imglib.Image(width, height); // Create Image buffer

    // YUV를 RGB로 변환
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex =
            uvPixelStride! * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // NV21 format
        var r = yp + vp * 1436 / 1024 - 179;
        var g = yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91;
        var b = yp + up * 1814 / 1024 - 227;
        // Clipping RGB values to be inside boundaries [ 0 , 255 ]
        r = r.clamp(0, 255).toDouble();
        g = g.clamp(0, 255).toDouble();
        b = b.clamp(0, 255).toDouble();
        img.data[index] =
            (0xFF << 24) | ((b.toInt()) << 16) | ((g.toInt()) << 8) | r.toInt();
      }
    }

    // JPEG로 인코딩
    imglib.JpegEncoder jpgEncoder = imglib.JpegEncoder();
    List<int> jpg = jpgEncoder.encodeImage(img);
    return Uint8List.fromList(jpg);
  } catch (e) {
    return Uint8List(0);
  }
}
