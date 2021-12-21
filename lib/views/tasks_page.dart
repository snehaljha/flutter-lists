import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_lists/db/app_database.dart';
import 'package:moor_lists/theme/app_theme.dart';

class TasksPage extends StatefulWidget {
  final String title;

  const TasksPage({Key? key, required this.title}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState(title);
}

class _TasksPageState extends State<TasksPage> {
  final String _title;

  _TasksPageState(this._title);

  @override
  Widget build(BuildContext context) {
    TextEditingController tfController = TextEditingController();

    return Container(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: AppDatabase().watchTasks(_title),
              builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text("No Data found"),
                  );

                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, index) {
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
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
                        child: InkWell(
                          onTap: () {
                            _changeDoneState(context, snapshot.data![index]);
                          },
                          child: Container(
                            padding: AppTheme.spacing.taskCardPadding,
                            child: Text(
                              snapshot.data![index].item,
                              style: TextStyle(
                                  color: AppTheme.colors.tasksTextColor,
                                  decoration: snapshot.data![index].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tfController,
                ),
              ),
              TextButton(
                  onPressed:
                      _addTask(context, tfController.text.toString().trim()),
                  child: Text("+",
                      style: TextStyle(
                          color: AppTheme.colors.textAdderButtonText)))
            ],
          )
        ],
      ),
    );
  }

  _delete(BuildContext ct, Task task) {
    AppDatabase().deleteTask(task);
  }

  _changeDoneState(BuildContext ct, Task task) {
    Task newTask =
        Task(title: task.title, item: task.item, isDone: !task.isDone);
    AppDatabase().changeDone(newTask);
  }

  _addTask(BuildContext ct, String text) {
    AppDatabase().addTask(Task(title: _title, item: text, isDone: false));
  }
}
