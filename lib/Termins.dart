import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './course.dart';
import 'Repository/Termin.dart';

class TerminWidget extends StatefulWidget {
  TerminWidget({super.key});

  @override
  State<TerminWidget> createState() => _TerminWidgetState();
}

class _TerminWidgetState extends State<TerminWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Termin>>(
          future: TerminDatabaseHelper.instance.getTermins(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Termin>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: const Text('No Termins in List.'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: snapshot.data!.map((termin) {
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    child: Text(
                                      termin.course_name,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        "Date: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(termin.termin_date))} Time: ${DateFormat.jm().format(DateTime.parse(termin.termin_date))}"),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
