import 'package:assignment05/datepickerwidget.dart';
import 'package:assignment05/list_provider.dart';
import 'package:assignment05/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'datepickerwidget.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _date;
  String taskID = "";

  @override
  void initState() {
    taskID = widget.task.taskID;
    _titleController.text = widget.task.title;
    _descController.text = widget.task.description;
    _date = widget.task.date;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Edit Task",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  label: Text("Title"), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: _descController,
              decoration: const InputDecoration(
                  label: Text("Description"), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 32,
            ),
            DateTimePicker_Widget(
              onClicked: (value) {
                _date = value;
              },
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                if (_date != null &&
                    _titleController.text != "" &&
                    _descController.text != "") {
                  context.read<ListProvider>().updateTask(widget.task,
                      _titleController.text, _descController.text, _date);
                }
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
