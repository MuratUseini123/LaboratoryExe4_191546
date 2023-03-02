import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './course.dart';

class Termin extends StatefulWidget {
  List<Course> courses;
  Termin({super.key, required this.courses});

  @override
  State<Termin> createState() => _TerminState();
}

class _TerminState extends State<Termin> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.courses.length,
        itemBuilder: (ctx, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    widget.courses.elementAt(index).course_name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).primaryColorLight),
                  ),
                ),
                Container(
                  child: Text(
                      "Date: ${DateFormat.yMMMMEEEEd().format(widget.courses.elementAt(index).termin_date)} Time: ${DateFormat.jm().format(widget.courses.elementAt(index).termin_date)}"),
                ),
              ],
            ),
          );
        },
      );
  }
}