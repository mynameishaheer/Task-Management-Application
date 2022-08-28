// import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String taskID;
  String title;
  String description;
  DateTime? date;
  DateTime? doneDate;
  bool isDone;

  Task(
      {required this.taskID,
      required this.title,
      required this.description,
      this.date,
      this.isDone = false,
      this.doneDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['taskID'] = taskID;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date!.toIso8601String();
    data['doneDate'] = doneDate?.toIso8601String();
    data['isDone'] = false;

    return data;
  }

  static Task fromJson(Map<String, dynamic> json) => Task(
        taskID: json['taskID'],
        title: json['title'],
        description: json['description'],
        date: DateTime.parse(json['date'] as String),
        doneDate: DateTime.parse(json['doneDate'] as String),
        isDone: json['isDone'],
      );

  String get getTitle => title;
  String get getDesc => description;
  DateTime? get getDate => date;
  bool get getComplete => isDone;
  DateTime? get getDoneDate => doneDate;
}
