import 'package:flutter/material.dart';
import './course.dart';
import './add_new_elem.dart';
import './calendar.dart';
import './Termins.dart';
import './myEvent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Termins',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Termins'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int auto_increment_value =
      2; //this is for keeping id counter so it can be used for deleting given entry
  MyHomePage({super.key, required this.title});
  String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewCourseTermin(
                _addNewTerminToList, widget.auto_increment_value),
          );
        });
    widget.auto_increment_value += 1;
  }

  void _showCalendar(BuildContext ctx, List<MyEvent> evs) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: MyCalendar(events: evs));
        });
  }

  void _addNewTerminToList(Course new_course_termin) {
    setState(() {
      courses.add(new_course_termin);
    });
  }

  List<Course> courses = [
    Course(1, "Computer Networks", DateTime.parse("2023-03-26 12:30:00")),
    Course(2, "Structured Programming", DateTime.parse("2023-03-27 14:45:00"))
  ];

  List<MyEvent> initEvents() {
    final List<MyEvent> evs = <MyEvent>[];
    for (var course in courses) {
      evs.add(MyEvent(course: course, c: Theme.of(context).primaryColor));
    }
    return evs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCalendar(context, initEvents()),
        tooltip: "Calendar",
        child: const Icon(Icons.calendar_month),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => _addItemFunction(context),
            icon: const Icon(Icons.add),
            tooltip: "Create new termin",
          ),
        ],
      ),
      body: Termin(courses: courses),
    );
  }
}
