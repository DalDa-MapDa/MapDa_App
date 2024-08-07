import 'package:intl/intl.dart';

class DateFormatter {
  /// DateTime 객체를 '24.11.10 13:07' 형식으로 포맷팅
  static String formatDateTime(DateTime dateTime) {
    final DateFormat format = DateFormat('yy.MM.dd HH:mm'); // 원하는 포맷 지정
    return format.format(dateTime); // DateTime 포맷팅
  }
}
