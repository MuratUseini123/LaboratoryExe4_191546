import 'package:flutter/material.dart';
import 'package:src/Repository/Termin.dart';

import 'Termins.dart';
import 'add_new_elem.dart';
import 'auth.dart';
import 'calendar.dart';
import 'course.dart';
import 'myEvent.dart';

class MyHomePage extends StatefulWidget {
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
            child: NewCourseTermin(),
          );
        }).whenComplete(() {
      setState(() {});
    });
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
  List<MyEvent> initEvents(){
    final List<MyEvent> evs = <MyEvent>[];
    List<Termin> termins = TerminHelper.temp;
    print(termins);
    for (var termin in termins) {
      evs.add(MyEvent(termin: termin, c: Theme.of(context).primaryColor));
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
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => _addItemFunction(context),
            icon: const Icon(Icons.add),
            tooltip: "Create new termin",
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
              icon: Icon(Icons.logout),
              tooltip: "Log out",
              onPressed: () {
                print(LoginAuth.isLoggedin);
                LoginAuth.isLoggedin = false;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginAuth()));
              }),
        ],
      ),
      body: TerminWidget(),
    );
  }
}
