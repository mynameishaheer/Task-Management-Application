import 'package:assignment05/edit_task.dart';
import 'package:assignment05/list_provider.dart';
import 'package:assignment05/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task View Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTask(task: widget.task),
                ),
              );
              setState(() {});
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.task.title,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.task.description,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Text(
                  "Due Date: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat("dd MMMM yyyy").format(widget.task.date!),
                  //task.date!.toIso8601String().substring(0, 10),
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            widget.task.date!.isBefore(DateTime.now())
                ? const Text(
                    "Due date has passed",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 30,
            ),
            !widget.task.isDone
                ? ElevatedButton(
                    onPressed: () {
                      context.read<ListProvider>().markAsDone(widget.task);
                      Navigator.pop(context);
                    },
                    child: const Text("Marks as Done"))
                : const SizedBox(),
            widget.task.isDone
                ? Text(
                    'Task completed on: \n${DateFormat("dd MMMM yyyy").format(widget.task.doneDate!)}',
                    // "Task completed on: ${task.doneDate!.toIso8601String().substring(0, 10)}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () async {
            bool flag = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Deletion"),
                  content: const Text(
                      "Doing so will remove the task permanently. Are you sure you want to proceed?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("No"))
                  ],
                );
              },
            );
            flag ? context.read<ListProvider>().deleteTask(widget.task) : null;
          },
          child: const Text("Delete"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
