import 'dart:async';
import 'package:eisenhower_todo/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/add_task_providers.dart';
import '../functions/backend.dart';
import 'dart:convert';
import '../providers/screen_manager.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _timeEstimateController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _dueTimeController = TextEditingController();

  Completer<void> _addTaskCompleter = Completer();
  var condition = false;

  @override
  void initState() {
    super.initState();
    _addTaskCompleter = Completer();
  }

  void _addTask(BuildContext context) {
    final taskText = _taskController.text;
    final dueDate = _dueDateController.text;
    final dueTime = _dueTimeController.text;
    final isUrgent = Provider.of<UrgencyProvider>(context, listen: false).isUrgent;
    final isImportant = Provider.of<ImportanceProvider>(context, listen: false).isImportant;
    final timeEstimate = _timeEstimateController.text;

    if (taskText.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false).addTask(
        Task(
          id: DateTime.now().toString(),
          title: taskText,
          isDone: false,
          dueDate: dueDate,
          isUrgent: isUrgent,
          isImportant: isImportant,
          timeEstimate: timeEstimate,
          dueTime: dueTime,
        ),
      );
      Provider.of<ScreenManager>(context, listen: false).selectScreen(0);
      Provider.of<UrgencyProvider>(context, listen: false).reset();
      Provider.of<ImportanceProvider>(context, listen: false).reset();
    }
  }

  void _addTask_NoNavigation(BuildContext context) {
    final taskText = _taskController.text;
    final dueDate = _dueDateController.text;
    final dueTime = _dueTimeController.text;
    final isUrgent = Provider.of<UrgencyProvider>(context, listen: false).isUrgent;
    final isImportant = Provider.of<ImportanceProvider>(context, listen: false).isImportant;
    final timeEstimate = _timeEstimateController.text;

    if (taskText.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false).addTask(
        Task(
          id: DateTime.now().toString(),
          title: taskText,
          isDone: false,
          dueDate: dueDate,
          isUrgent: isUrgent,
          isImportant: isImportant,
          timeEstimate: timeEstimate,
          dueTime: dueTime,
        ),
      );
    }
  }

  Future<void> _submitToChat(BuildContext context) async {
    final chatText = _chatController.text;
    if (chatText.isNotEmpty) {
      // Implement chat submission logic
      var response = await sendData(chatText);
      var tasks = jsonDecode(response)['yourData'];
      print(tasks);
      if (tasks.length > 1) {
        condition = true;
      }
      for (var task in tasks) {
        _addTaskCompleter = Completer();
        // Update the text fields with the task data
        _taskController.text = task['task'];
        _dueDateController.text = task['due'];
        if (task['due_time'] == "[NOT GIVEN]")
          _dueTimeController.text = "";
        else {
          _dueTimeController.text = task['due_time'];
        }

        // Update the urgency and importance checkboxes with the task data
        var urgency = task['urgent'] == 'Yes' ? true : false;
        var importance = task['important'] == 'Yes' ? true : false;

        // Update the urgency and importance providers with the task data
        Provider.of<UrgencyProvider>(context, listen: false).isUrgent = urgency;
        Provider.of<ImportanceProvider>(context, listen: false).isImportant = importance;

        await _addTaskCompleter.future;
        print('added');
        // Clear the text fields and checkboxes
        _taskController.clear();
        _dueDateController.clear();
        _timeEstimateController.clear();
        _dueTimeController.clear();
        Provider.of<UrgencyProvider>(context, listen: false).reset();
        Provider.of<ImportanceProvider>(context, listen: false).reset();

        // Wait for 2 seconds before adding the next task
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    _chatController.clear();
    // Show a pop-up dialog with the message "All tasks added"
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('All tasks added'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Add a TextField to input the tasks info
              _taskNameInputBuilder(),
              const SizedBox(height: 20),
              _dueDateInputBuilder(),
              const SizedBox(height: 20),
              _urgencyAndImportanceInputBuilder(),
              const SizedBox(height: 20),
              _timeEstInputBuilder(),
              const SizedBox(height: 20),
              _dueTimeInputBuilder(),
              const SizedBox(height: 20),
              //  Add an ElevatedButton to submit the task
              ElevatedButton(
                onPressed: () {
                  condition
                      ? _addTask_NoNavigation(context)
                      : _addTask(context);
                  _addTaskCompleter.complete();
                },
                child: const Text('Add Task'),
              ),
              const SizedBox(height: 20),
              _chatInputBuilder(),
              const SizedBox(height: 10),
              //  Add an ElevatedButton to submit the chat to backend
              ElevatedButton(
                onPressed: () => _submitToChat(context),
                child: const Text('Submit to Gemini'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _chatInputBuilder() {
    return TextField(
      controller: _chatController,
      decoration: const InputDecoration(
        labelText: 'Chat Input',
        hintText: 'Write out task in plain text',
      ),
    );
  }

  TextField _timeEstInputBuilder() {
    return TextField(
      controller: _timeEstimateController,
      decoration: const InputDecoration(
        labelText: 'Time Estimate',
        hintText: 'Enter time estimate in hours (optional)',
      ),
    );
  }

  TextField _dueTimeInputBuilder() {
    return TextField(
      controller: _dueTimeController,
      decoration: const InputDecoration(
        labelText: 'Due Time',
        hintText: 'hh:mm AM/PM(Optional)',
      ),
    );
  }

  Widget _urgencyAndImportanceInputBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Consumer<UrgencyProvider>(
            builder: (context, urgencyProvider, child) => CheckboxListTile(
              title: const Text('Urgent'),
              value: urgencyProvider.isUrgent,
              onChanged: (newValue) {
                if (newValue != null) {
                  urgencyProvider.isUrgent = newValue;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Consumer<ImportanceProvider>(
            builder: (context, importanceProvider, child) => CheckboxListTile(
              title: const Text('Important'),
              value: importanceProvider.isImportant,
              onChanged: (newValue) {
                if (newValue != null) {
                  importanceProvider.isImportant = newValue;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  TextField _dueDateInputBuilder() {
    return TextField(
      controller: _dueDateController,
      decoration: const InputDecoration(
        labelText: 'Due Date',
        hintText: 'MM/DD/YYYY',
      ),
    );
  }

  TextField _taskNameInputBuilder() {
    return TextField(
      controller: _taskController,
      decoration: const InputDecoration(
        labelText: 'Task',
        hintText: 'Enter task name',
      ),
    );
  }
}
