import 'package:assignment05/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  List<Task> _list = [];

  List<Task> get list => _list;

  Future getTask() async {
    _list = [];

    await tasks.get().then(
      (QuerySnapshot qs) {
        for (var doc in qs.docs) {
          Task task = Task.fromJson(doc.data() as Map<String, dynamic>);
          _list.add(task);
        }
      },
    );
    notifyListeners();
  }

  Future<void> addTask(String title, String desc, DateTime? date) async {
    String taskid = tasks.doc().id;
    final task = Task(
      taskID: taskid,
      title: title,
      description: desc,
      date: date,
    );
    tasks.doc(taskid).set(task.toJson());
    _list.add(task);
    notifyListeners();
  }

  void updateTask(Task task, String title, String desc, DateTime? date) {
    tasks.doc(task.taskID).update(
      {
        'title': title,
        'description': desc,
        'date': date,
      },
    );

    task.title = title;
    task.description = desc;
    task.date = date;

    notifyListeners();
  }

  void markAsDone(Task task) {
    tasks.doc(task.taskID).update(
      {
        'isDone': true,
        'doneDate': DateTime.now().toIso8601String(),
      },
    );

    task.isDone = true;
    task.doneDate = DateTime.now();
    notifyListeners();
  }

  void markAsNotDone(Task task) {
    tasks.doc(task.taskID).update(
      {
        'isDone': false,
      },
    );
    task.isDone = false;
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.doc(task.taskID).delete();

    _list.remove(task);

    notifyListeners();
  }
}
