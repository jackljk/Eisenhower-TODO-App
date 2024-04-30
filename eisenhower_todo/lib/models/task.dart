class Task {
  final String id;
  final String title;
  final String dueDate;
  final bool isUrgent;
  final bool isImportant;
  final DateTime timestampCreated = DateTime.now();
  String? dueTime;
  String? timeEstimate = '';
  DateTime? timeStampCompleted; 
  bool isDone;


  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isUrgent,
    required this.isImportant,
    this.dueTime,
    this.timeEstimate,
    this.timeStampCompleted,
    required this.isDone,
  });

  static fromJson(String response) {}
}