import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'myEvent.dart';

class MyCalendar extends StatelessWidget {
  final List<MyEvent> events;
  const MyCalendar({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 0, 10),
                  child: ElevatedButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: Text("Go Back"),
                  )),
            ],
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MyEventDataSource(events),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
            ),
          ),
        ],
      ),
    );
  }
}
