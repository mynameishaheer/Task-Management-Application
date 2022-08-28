import 'package:assignment05/add_task.dart';
import 'package:assignment05/list_provider.dart';
// import 'package:assignment05/task.dart';
import 'package:assignment05/task_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    load();

    super.initState();
  }

  void load() {
    context.read<ListProvider>().getTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final list = context.watch<ListProvider>().list;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
      ),
      body: Center(
        child: list.isEmpty
            ? const Text('No Tasks')
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TaskPage(
                            task: list[index],
                          ),
                        ));
                      },
                      child: Card(
                        elevation: 3,
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(list[index].title),
                          subtitle: Text(
                              'Due: ${DateFormat("dd MMMM yyyy").format(list[index].date!)}'),
                          //"Due: ${list[index].date?.toIso8601String().substring(0, 10)}"),
                          leading: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
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
                              flag
                                  ? context
                                      .read<ListProvider>()
                                      .deleteTask(list[index])
                                  : null;
                            },
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      if (!list[index].isDone) {
                                        context
                                            .read<ListProvider>()
                                            .markAsDone(list[index]);
                                      } else {
                                        context
                                            .read<ListProvider>()
                                            .markAsNotDone(list[index]);
                                      }
                                    },
                                    child: Icon(
                                      !list[index].isDone
                                          ? Icons.circle_outlined
                                          : Icons.check_circle,
                                      color: Colors.green,
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                list[index].date!.isBefore(DateTime.now())
                                    ? Container(
                                        height: 60,
                                        width: 20,
                                        color: Colors.red,
                                      )
                                    : const SizedBox(
                                        height: 70,
                                        width: 15,
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(),
            ),
          );
        },
      ),
    );
  }
}
