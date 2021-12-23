import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_lists/db/app_database.dart';
import 'package:moor_lists/theme/app_theme.dart';
import 'package:moor_lists/views/dialogs.dart';
import 'package:moor_lists/views/tasks_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lists',
          style: TextStyle(color: AppTheme.colors.pageTitleText),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppTheme.colors.pageTitleText,
        ),
        onPressed: () {
          _createOrRename(context, true, "");
        },
      ),
      backgroundColor: AppTheme.colors.pageBackground,
      body: Container(
        child: StreamBuilder(
          stream: AppDatabase().watchTitles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String?>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('No Lists found'));
            }
            return ListView.builder(
              itemBuilder: (_, index) {
                return Slidable(
                  endActionPane: ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      backgroundColor: AppTheme.colors.renameActionBackground,
                      foregroundColor: AppTheme.colors.actionForeground,
                      icon: Icons.edit_outlined,
                      label: 'Rename',
                      onPressed: (context) {
                        _createOrRename(context, false, snapshot.data![index]!);
                      },
                    ),
                    SlidableAction(
                      backgroundColor: AppTheme.colors.deleteActionBackround,
                      foregroundColor: AppTheme.colors.actionForeground,
                      icon: Icons.delete_outlined,
                      label: 'Delete',
                      onPressed: (context) {
                        _delete(context, snapshot.data![index]!);
                      },
                    )
                  ]),
                  child: Card(
                      color: AppTheme.colors.listTitlesBGColor,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TasksPage(title: snapshot.data![index]!)));
                        },
                        leading: CircleAvatar(
                          child: Text(
                            '${index + 1}',
                          ),
                          radius: 20,
                        ),
                        title: Text(
                          snapshot.data![index]!,
                          style:
                              TextStyle(color: AppTheme.colors.listTitlesColor),
                        ),
                      )),
                );
              },
              itemCount: snapshot.data?.length,
            );
          },
        ),
      ),
    );
  }

  _createOrRename(BuildContext ct, bool isNew, String origName) {
    Dialogs.createOrRenameListDialog(isNew, ct).then((value) {
      if (value == null) return;
      String res = value.toString();
      if (res.trim() == '') {
        SnackBar sb = SnackBar(content: Text("List Name can't be $res"));
        ScaffoldMessenger.of(ct).showSnackBar(sb);
        return;
      }
      AppDatabase().getTasks(res).then((value) async {
        List<Task> val = value;
        if (val.isNotEmpty) {
          SnackBar sb = SnackBar(content: Text("List $res already exists"));
          ScaffoldMessenger.of(ct).showSnackBar(sb);
          return;
        }

        if (isNew) {
          await Navigator.of(ct)
              .push(MaterialPageRoute(builder: (ct) => TasksPage(title: res)))
              .then((value) {
            setState(() {});
          });
        } else {
          AppDatabase().renameTitle(origName, res);
          setState(() {});
        }

        //enter new Screen;
      });
    });
  }

  _delete(BuildContext ct, String listName) {
    Dialogs.deleteDialog(ct).then((value) {
      if (value == null) return;
      if (value as bool == true) {
        AppDatabase().deleteTitle(listName);
        setState(() {});
      }
    });
  }
}
