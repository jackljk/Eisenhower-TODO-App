import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../functions/info_parsers.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;

  TasksList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.grey[200], // Change this to your desired color
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (ctx, index) {
                  final task = tasks.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: createTaskTile(task, context),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget createTaskTile(Task task, BuildContext context) {
    return TaskTile(
      title: task.title,
      isDone: task.isDone,
      dueDate: parseDate(task.dueDate),
      isUrgent: task.isUrgent,
      isImportant: task.isImportant,
      timeEstimate: task.timeEstimate ?? '',
      dueTime: parseTime(task.dueTime),
      timestampCreated: task.timestampCreated,
      onChanged: (value) {
        // Implement task completion logic
        // Provider.of<TaskProvider>(context, listen: false).updateTaskStatus(task.id, value);
      },
    );
  }
}
