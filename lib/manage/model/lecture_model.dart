// lecture_model.dart
class Lecture {
  final String lname;
  final List<String> day;
  final List<int> start;
  final List<int> end;
  final List<String> classroom;

  Lecture({
    required this.lname,
    required this.day,
    required this.start,
    required this.end,
    required this.classroom,
  });
}
