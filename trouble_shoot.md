문제: UnmodifiableUint8ListView 자료형이 플러터에서 지원되지 않음.
해결: 다른 방식으로 인식할 수 있도록 우회

"""
Launching lib/main.dart on sdk gphone64 arm64 in debug mode...
../../../.pub-cache/hosted/pub.dev/tflite_flutter-0.9.1/lib/src/tensor.dart:38:12: Error: The method 'UnmodifiableUint8ListView' isn't defined for the class 'Tensor'.
 - 'Tensor' is from 'package:tflite_flutter/src/tensor.dart' ('../../../.pub-cache/hosted/pub.dev/tflite_flutter-0.9.1/lib/src/tensor.dart').
Try correcting the name to the name of an existing method, or defining a method named 'UnmodifiableUint8ListView'.
    return UnmodifiableUint8ListView
           ^^^^^^^^^^^^^^^^^^^^^^^^^
Target kernel_snapshot_program failed: Exception

FAILURE: Build failed with an exception.
"""
에러 발생 시 tensor.dart파일의 Uint8List get data 부분을 아래로 변경

"""
/// Underlying data buffer as bytes.
Uint8List get data {
  final data = cast<Uint8>(tfLiteTensorData(_tensor));
  return Uint8List.view(data.asTypedList(tfLiteTensorByteSize(_tensor)).buffer);
}
"""