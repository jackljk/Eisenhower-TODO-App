import 'package:flutter/material.dart';
import '../functions/info_parsers.dart';


class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final DateTime dueDate;
  final DateTime? dueTime;
  final String timeEstimate;
  final bool isUrgent;
  final bool isImportant;
  final Function(bool) onChanged;

  TaskTile({
    required this.title,
    required this.isDone,
    required this.onChanged,
    required this.dueDate,
    required this.timeEstimate,
    required this.isUrgent,
    required this.isImportant,
    required this.dueTime,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      // ignore: unnecessary_null_comparison, unrelated_type_equality_checks
      subtitle: Text('${displayDate(dueDate)} ${displayTime(dueTime)}'),
      leading: Checkbox(
          value: isDone,
          onChanged: (bool? value) {
            if (value != null) {
              onChanged(value);  // Ensure the parent widget updates the task status
            }
          },
        ),
      trailing: timeEstimate != ''
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeEstimate,
                style: const TextStyle(fontSize: 18.0),
              ),
              const Icon(Icons.access_time, size: 18.0), // Use the Material clock icon
            ],
          )
        : const SizedBox(),
      shape: Border.all(color: Colors.transparent),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Status: ${isDone ? 'Done' : 'Not Done'}'),
                    const Spacer(),
                    Text("Urgent: ${isUrgent ? 'Yes' : 'No'}"),
                    const Spacer(),
                    Text("Important: ${isImportant ? 'Yes' : 'No'}")
                  ],
                ),
              ],       
            ),
          ),
          ),
        // Add more information here
      ],
    );
  }
}