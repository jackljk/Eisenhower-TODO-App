import 'package:flutter/material.dart';
import '../functions/info_parsers.dart';

class TaskTile extends StatefulWidget{
  final String title;
  final bool isDone;
  final DateTime dueDate;
  final DateTime? dueTime;
  final String timeEstimate;
  final bool isUrgent;
  final bool isImportant;
  final Function(bool) onChanged;
  final DateTime timestampCreated;

  TaskTile({
    required this.title,
    required this.isDone,
    required this.onChanged,
    required this.dueDate,
    required this.timeEstimate,
    required this.isUrgent,
    required this.isImportant,
    required this.dueTime,
    required this.timestampCreated,
  });

  @override
  _TaskTileState createState() => _TaskTileState();

}

class _TaskTileState extends State<TaskTile> {

  bool _isDone = false;

  
  @override
  void initState() {
    super.initState();
    _isDone = widget.isDone;
  }

  String get title => widget.title;
  bool get isUrgent => widget.isUrgent;
  bool get isImportant => widget.isImportant;
  DateTime get dueDate => widget.dueDate;
  DateTime? get dueTime => widget.dueTime;
  String get timeEstimate => widget.timeEstimate;
  DateTime get timestampCreated => widget.timestampCreated;



  double _calculateProgress() {
    DateTime now = DateTime.now();
    DateTime dueDateTime = dueDate;

    // If dueTime is provided, adjust dueDateTime to include the time
    if (dueTime != null) {
      dueDateTime = DateTime(
        dueDateTime.year,
        dueDateTime.month,
        dueDateTime.day,
        dueTime!.hour,
        dueTime!.minute,
      );
    }
    print(dueDateTime);
    if (dueDateTime.isBefore(now)) return 1.0; // Task is past due
    print(now);
    print(dueDateTime);
    Duration totalDuration = dueDateTime.difference(timestampCreated);
    Duration elapsedDuration = now.difference(timestampCreated);

    return elapsedDuration.inSeconds / totalDuration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    double progress = _calculateProgress();

    return Container(
      padding:
          const EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        color: (bool isUrgent, bool isImportant) {
          if (isUrgent && isImportant) {
            return Colors.purple.shade200;
          } else if (isUrgent) {
            return Colors.orange.shade200;
          } else if (isImportant) {
            return Colors.green.shade200;
          } else {
            return Colors.red.shade200;
          }
        }(isUrgent, isImportant),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // ignore: unnecessary_null_comparison, unrelated_type_equality_checks
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue,
            minHeight: 5,
          ),
        ),
        leading: Checkbox(
          value: _isDone,
          onChanged: (value) {
            setState(() {
              _isDone = value!;
              widget.onChanged(value);
            });
          },
        ),
        trailing: timeEstimate != ''
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeEstimate,
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.access_time,
                    size: 18.0,
                    color: Colors.white,
                  ), // Use the Material clock icon
                ],
              )
            : const SizedBox(),
        shape: Border.all(color: Colors.transparent),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Status: ${_isDone ? 'Done' : 'Not Done'}'),
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
      ),
    );
  }
}
