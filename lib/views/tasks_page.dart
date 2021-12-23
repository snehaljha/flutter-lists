import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_lists/db/app_database.dart';
import 'package:moor_lists/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';

class TasksPage extends StatefulWidget {
  final String title;

  const TasksPage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TasksPageState createState() => _TasksPageState(title);
}

class _TasksPageState extends State<TasksPage> {
  final String _title;

  _TasksPageState(this._title);

  @override
  Widget build(BuildContext context) {
    TextEditingController tfController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.colors.pageTitleText,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _title,
                style: TextStyle(color: AppTheme.colors.pageTitleText),
              ),
            ),
            InkWell(
              onTap: () {
                _shareList(context);
              },
              child: Icon(
                Icons.share,
                color: AppTheme.colors.pageTitleText,
              ),
            )
          ],
        ),
      ),
      backgroundColor: AppTheme.colors.pageBackground,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: AppDatabase().watchTasks(_title),
              builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                    child: Center(
                      child: Text("No Data found"),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, index) {
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          backgroundColor:
                              AppTheme.colors.deleteActionBackround,
                          foregroundColor: AppTheme.colors.actionForeground,
                          icon: Icons.delete_outlined,
                          label: 'Delete',
                          onPressed: (context) {
                            _delete(context, snapshot.data![index]);
                          },
                        )
                      ]),
                      child: Card(
                        color: AppTheme.colors.tasksBGColor,
                        child: ListTile(
                          onTap: () {
                            _changeDoneState(context, snapshot.data![index]);
                          },
                          title: Text(
                            snapshot.data![index].item,
                            style: TextStyle(
                                color: AppTheme.colors.tasksTextColor,
                                decoration: snapshot.data![index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            margin: AppTheme.spacing.textBoxMargin,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: AppTheme.colors.tasksTextColor),
                    controller: tfController,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.colors.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                  child: TextButton(
                      onPressed: () {
                        _addTask(context, tfController.text.toString().trim());
                      },
                      child: Text("+",
                          style: TextStyle(
                              fontSize: 28,
                              color: AppTheme.colors.textAdderButtonText))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _delete(BuildContext ct, Task task) {
    AppDatabase().deleteTask(task);
    setState(() {});
  }

  _changeDoneState(BuildContext ct, Task task) {
    Task newTask =
        Task(title: task.title, item: task.item, isDone: !task.isDone);
    AppDatabase().changeDone(newTask);
    setState(() {});
  }

  _addTask(BuildContext ct, String text) {
    if (text == '') return;
    AppDatabase().addTask(Task(title: _title, item: text, isDone: false));
    setState(() {});
  }

  _shareList(BuildContext ct) async {
    String text = await _parseTasks();
    if (text != '') Share.share(text);
  }

  Future<String> _parseTasks() async {
    String res = '';
    List<Task> tasks = await AppDatabase().getTasks(_title);
    if (tasks.isEmpty) return res;
    res = _title + ' :-';
    for (Task task in tasks) {
      res += '\n ${task.item}';
    }
    return res;
  }
}
