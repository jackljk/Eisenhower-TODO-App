import 'package:eisenhower_todo/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      appBar: createAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 16,
              right: 16,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 241, 241, 241),
                suffixIcon: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Clear the search field
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: tasksList(tasks, context),
          ),
        ],
      ),
      // Add a floating action button
      floatingActionButton: addTaskButton(context),
    );
  }

  FloatingActionButton addTaskButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/add-task');
        Provider.of<UrgencyProvider>(context, listen: false).reset();
        Provider.of<ImportanceProvider>(context, listen: false).reset();
      },
      child: const Icon(Icons.add),
    );
  }

  Column tasksList(List<Task> tasks, BuildContext context) {
    return Column(
      children: [
        const Text('Urgent and Important'),
        ListView.builder(
          shrinkWrap: true,
          itemCount:
              tasks.where((task) => task.isUrgent && task.isImportant).length,
          itemBuilder: (ctx, index) {
            final task = tasks
                .where((task) => task.isUrgent && task.isImportant)
                .toList()[index];
            return createTaskTile(task, context);
          },
        ),
        const Text('Urgent but not Important'),
        ListView.builder(
          shrinkWrap: true,
          itemCount:
              tasks.where((task) => task.isUrgent && !task.isImportant).length,
          itemBuilder: (ctx, index) {
            final task = tasks
                .where((task) => task.isUrgent && !task.isImportant)
                .toList()[index];
            return createTaskTile(task, context);
          },
        ),
        const Text('Not Urgent but Important'),
        ListView.builder(
          shrinkWrap: true,
          itemCount:
              tasks.where((task) => !task.isUrgent && task.isImportant).length,
          itemBuilder: (ctx, index) {
            final task = tasks
                .where((task) => !task.isUrgent && task.isImportant)
                .toList()[index];
            return createTaskTile(task, context);
          },
        ),
        const Text('Not Urgent and not Important'),
        ListView.builder(
          shrinkWrap: true,
          itemCount:
              tasks.where((task) => !task.isUrgent && !task.isImportant).length,
          itemBuilder: (ctx, index) {
            final task = tasks
                .where((task) => !task.isUrgent && !task.isImportant)
                .toList()[index];
            return createTaskTile(task, context);
          },
        ),
      ],
    );
  }

  AppBar createAppBar() {
    return AppBar(
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/banner/bg4.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text("Hey Grace!\nWelcome back!",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 238, 238),
              fontSize: 24,
              fontWeight: FontWeight.bold)),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(''),
          radius: 20,
        ),
        SizedBox(width: 16),
      ],
      toolbarHeight: 120.0,
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
