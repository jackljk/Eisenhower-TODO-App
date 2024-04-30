import 'package:eisenhower_todo/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/add_task_providers.dart';
import '../widgets/task_tile.dart';
import '../functions/info_parsers.dart';
import '../functions/backend.dart';




class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;

    return buildTaskListView(tasks, context);
  }

  Scaffold buildTaskListView(List<Task> tasks, BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Todo List'),
    ),
    body: Column(
  children: [
    const Text('Urgent and Important'),
    ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.where((task) => task.isUrgent && task.isImportant).length,
      itemBuilder: (ctx, index) {
        final task = tasks.where((task) => task.isUrgent && task.isImportant).toList()[index];
        return createTaskTile(task, context);
      },
    ),
    const Text('Urgent but not Important'),
    ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.where((task) => task.isUrgent && !task.isImportant).length,
      itemBuilder: (ctx, index) {
        final task = tasks.where((task) => task.isUrgent && !task.isImportant).toList()[index];
        return createTaskTile(task, context);
      },
    ),
    const Text('Not Urgent but Important'),
    ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.where((task) => !task.isUrgent && task.isImportant).length,
      itemBuilder: (ctx, index) {
        final task = tasks.where((task) => !task.isUrgent && task.isImportant).toList()[index];
        return createTaskTile(task, context);
      },
    ),
    const Text('Not Urgent and not Important'),
    ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.where((task) => !task.isUrgent && !task.isImportant).length,
      itemBuilder: (ctx, index) {
        final task = tasks.where((task) => !task.isUrgent && !task.isImportant).toList()[index];
        return createTaskTile(task, context);
      },
    ),
  ],
),
    
    // Add a floating action button
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/add-task');
        Provider.of<UrgencyProvider>(context, listen: false).reset();
        Provider.of<ImportanceProvider>(context, listen: false).reset();
      },
      child: const Icon(Icons.add),
    ),
  );
  }

  TaskTile createTaskTile(Task task, BuildContext context) {
    return TaskTile(
        title: task.title,
        isDone: task.isDone,
        dueDate: parseDate(task.dueDate),
        isUrgent: task.isUrgent,
        isImportant: task.isImportant,
        timeEstimate: task.timeEstimate ?? '',
        dueTime: parseTime(task.dueTime),
        onChanged: (value) {
          // Implement task completion logic
          // Provider.of<TaskProvider>(context, listen: false).updateTaskStatus(task.id, value);
        },
      );
  }
}