// timetable_widget.dart
import 'package:flutter/material.dart';
import 'package:mapda/constants/manage/model_manage.dart';

List week = ['월', '화', '수', '목', '금'];
var kColumnLength = 22;
double kFirstColumnHeight = 20;
double kBoxSize = 52;

class TimetableWidget extends StatefulWidget {
  final List<Lecture> selectedLectures;

  const TimetableWidget({super.key, required this.selectedLectures});

  @override
  _TimetableWidgetState createState() => _TimetableWidgetState();
}

class _TimetableWidgetState extends State<TimetableWidget> {
  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength.toInt(),
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int index) {
    String currentDay = week[index];
    List<Widget> lecturesForTheDay = [];

    for (var lecture in widget.selectedLectures) {
      for (int i = 0; i < lecture.day.length; i++) {
        double top = kFirstColumnHeight + (lecture.start[i] / 60.0) * kBoxSize;
        double height = ((lecture.end[i] - lecture.start[i]) / 60.0) * kBoxSize;

        if (lecture.day[i] == currentDay) {
          lecturesForTheDay.add(
            Positioned(
              top: top,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedLectures.remove(lecture);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Text(
                    "${lecture.lname}\n${lecture.classroom[i]}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    '${week[index]}',
                  ),
                ),
                ...List.generate(
                  kColumnLength.toInt(),
                  (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
            ...lecturesForTheDay, // 현재 요일에 해당하는 모든 강의를 Stack에 추가
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (kColumnLength / 2 * kBoxSize) + kFirstColumnHeight,
      child: Row(
        children: [
          buildTimeColumn(),
          ...buildDayColumn(0),
          ...buildDayColumn(1),
          ...buildDayColumn(2),
          ...buildDayColumn(3),
          ...buildDayColumn(4),
        ],
      ),
    );
  }
}
