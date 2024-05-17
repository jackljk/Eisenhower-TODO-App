import 'package:flutter/material.dart';


class ScreenManager with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  Color get selectedColor => _colors[_selectedIndex];
  Color get unSelectedColor => Colors.grey;


  final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.orange,
  ];

  void selectScreen(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
