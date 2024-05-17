import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/screen_manager.dart';
import '../providers/task_provider.dart';
import '../providers/add_task_providers.dart';
import '../widgets/task_tile.dart';
import '../functions/info_parsers.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';
import 'analytics_screen.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../widgets/eisenhower_task_tile.dart';
import '../widgets/task_list_tile.dart';

class HomeScreen extends StatelessWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    TaskListView(),
    CalendarScreen(),
    AddTaskScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
    // Add more screens if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(
        Provider.of<ScreenManager>(context).selectedIndex,
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  SnakeNavigationBar bottomNavBar(context) {
    return SnakeNavigationBar.color(
        height: 70,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: Colors.black26,
        selectedItemColor:
            Provider.of<ScreenManager>(context).selectedColor, 
        unselectedItemColor: Provider.of<ScreenManager>(context).unSelectedColor,

        ///configuration for SnakeNavigationBar.gradient
        shadowColor: Colors.grey,
        

        showUnselectedLabels: false,
        showSelectedLabels: false,

        currentIndex: Provider.of<ScreenManager>(context).selectedIndex,
        onTap: (index) {
          Provider.of<ScreenManager>(context, listen: false)
              .selectScreen(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Charts/Analytics'),
              BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),

        backgroundColor: Colors.black,
        
      );
  }
}

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;

    return buildHomeView(tasks, context);
  }

  Scaffold buildHomeView(List<Task> tasks, BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 16,
              right: 16,
            ),
            child: searchBar(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: eisenhowerTaskTile(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TasksList(tasks: tasks),
          )
        ],
      ),
    );
  }

  TextField searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 241, 241),
        suffixIcon: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            // Clear the search field
          },
        ),
      ),
    );
  }

  

  AppBar createAppBar() {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: ClipRRect(
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
          backgroundImage: AssetImage(
              'assets/avatar.png'), // Update with the correct image asset
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
        Provider.of<TaskProvider>(context, listen: false)
            .updateTaskStatus(task.id, value);
      },
      timestampCreated: task.timestampCreated,
    );
  }
}
