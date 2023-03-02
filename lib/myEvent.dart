import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'course.dart';

class MyEvent{
  final Course course;
  final Color c;
  MyEvent({required this.course, required this.c});
}


class MyEventDataSource extends CalendarDataSource{
  MyEventDataSource(List<MyEvent> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).course.termin_date;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).course.termin_date;
  }

  @override
  String getSubject(int index) {
    return '${_getEventData(index).course.course_name} - ${DateFormat.Hm().format(_getEventData(index).course.termin_date)}';
  }

  @override
  Color getColor(int index) {
    return _getEventData(index).c;
  }

  MyEvent _getEventData(int index) {
    final dynamic event = appointments![index];
    late final MyEvent eventData;
    if (event is MyEvent) {
      eventData = event;
    }

    return eventData;
  }
}