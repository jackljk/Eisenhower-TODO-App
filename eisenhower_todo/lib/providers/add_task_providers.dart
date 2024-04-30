import 'package:flutter/foundation.dart';

class UrgencyProvider with ChangeNotifier {
  bool _isUrgent = false;

  bool get isUrgent => _isUrgent;

  set isUrgent(bool newValue) {
    _isUrgent = newValue;
    notifyListeners();
  }

  void reset() {
    _isUrgent = false;
    notifyListeners();
  }
}

class ImportanceProvider with ChangeNotifier {
  bool _isImportant = false;

  bool get isImportant => _isImportant;

  set isImportant(bool newValue) {
    _isImportant = newValue;
    notifyListeners();
  }

  void reset() {
    _isImportant = false;
    notifyListeners();
  }
}
