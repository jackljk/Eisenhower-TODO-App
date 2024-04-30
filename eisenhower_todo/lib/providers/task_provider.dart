import 'package:flutter/foundation.dart';
import '../models/task.dart';
import 'dart:async';


class TaskProvider with ChangeNotifier {
  // Implement a list of tasks
  List<Task> _tasks = [];

  // Implement a getter to return the list of tasks
  List<Task> get tasks {
    return List.from(_tasks);
  }

  // Implement a method to add tasks
  /// Adds a task to the task list.
  ///
  /// This method adds the given [task] to the list of tasks and notifies any
  /// listeners that the task list has been updated.
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Implement methods to update and delete tasks
  // void sortTasks() {
  //   _tasks.sort((a, b) {
  //     if (a.isDone && !b.isDone) {
  //       return 1;
  //     } else if (!a.isDone && b.isDone) {
  //       return -1;
  //     } else {
  //       return a.timestampCreated.compareTo(b.timestampCreated);
  //     }
  //   });
  //   notifyListeners();
  // }




  /// Deletes a task with the specified [id].
  ///
  /// Removes the task from the list of tasks [_tasks] if the task's id matches the specified [id].
  /// Notifies listeners after the task is deleted.
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  /// Updates the status of a task with the specified [id].
  ///
  /// Finds the index of the task with the specified [id] in the list of tasks [_tasks].
  /// Updates the task's isDone property with the specified [isDone] value.
  /// Updates the task's timeStampCompleted property with the current date and time.
  /// Notifies listeners after the task is updated.
  void updateTaskStatus(String id, bool isDone) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    _tasks[taskIndex].isDone = isDone;
    if (isDone) {
      _tasks[taskIndex].timeStampCompleted = DateTime.now();
    } else {
      _tasks[taskIndex].timeStampCompleted = null;
    }
    notifyListeners();
  }



  // You can also add methods for fetching and managing tasks
  /// Deletes expired tasks from the task list.
  ///
  /// This method removes tasks from the list that are marked as done and have a
  /// completion timestamp, but the time difference between the current time and
  /// the completion timestamp is greater than or equal to 5 minutes.
  void deleteExpiredTasks() {
    final currentTime = DateTime.now();
    _tasks.removeWhere((task) {
      if (!task.isDone || task.timeStampCompleted == null) {
        return false;
      }
      final timeDifference = currentTime.difference(task.timeStampCompleted!);
      return timeDifference.inMinutes >= 1;
    });
    notifyListeners();
  }


  // Implement a constructor to start the cleanup timer
  TaskProvider() {
    _update();
  }

  void _update() {
    Timer.periodic(Duration(minutes: 2), (timer) {
      deleteExpiredTasks();
    });
  }
}