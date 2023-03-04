import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Repository/Termin.dart';

class NewCourseTermin extends StatefulWidget {
  const NewCourseTermin({super.key});

  @override
  State<StatefulWidget> createState() => _NewCourseTerminState();
}

class _NewCourseTerminState extends State<NewCourseTermin> {
  // ignore: non_constant_identifier_names
  final _CourseNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _TerminDateController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _TerminTimeController = TextEditingController();
  void _submitTermin() async {
    await TerminDatabaseHelper.instance.addTermin(Termin(
      course_name: _CourseNameController.text,
      termin_date: "${_TerminDateController.text} ${_TerminTimeController.text}",
      created_by: 1,
    ));
    setState(() {
      _CourseNameController.clear();
      _TerminDateController.clear();
    });
    _TerminDateController.clear();
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _CourseNameController,
            decoration: const InputDecoration(labelText: "Enter Course Name"),
            onSubmitted: (_) => _submitTermin(),
          ),
          TextField(
            controller: _TerminDateController,
            decoration: const InputDecoration(labelText: "Enter termin date"),
            onSubmitted: (_) => _submitTermin(),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000),
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _TerminDateController.text =
                      formattedDate; 
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          TextField(
            controller: _TerminTimeController,
            decoration: const InputDecoration(labelText: "Enter termin time"),
            onSubmitted: (_) => _submitTermin(),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (pickedTime != null) {
                print(pickedTime.format(context));
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());
                print(parsedTime); 
                String formattedTime =
                    DateFormat('HH:mm:ss').format(parsedTime);
                setState(() {
                  _TerminTimeController.text =
                      formattedTime;
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              _submitTermin();
            },
            child: const Text("Create new termin"),
          ),
        ],
      ),
    );
  }
}
