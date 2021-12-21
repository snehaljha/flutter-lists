import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_lists/model/tasks.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'moorList.sqlite', logStatements: true));
  int get schemaVersion => 1;

  Future<List<String?>> getTitles() {
    final query = selectOnly(tasks, distinct: true)..addColumns([tasks.title]);
    return query.map((row) => row.read(tasks.title)).get();
  }

  Stream<List<String?>> watchTitles() {
    final query = selectOnly(tasks, distinct: true)..addColumns([tasks.title]);
    return query.map((row) => row.read(tasks.title)).watch();
  }

  Future<List<Task>> getTasks(String title) =>
      (select(tasks)..where((task) => task.title.equals(title))).get();

  Stream<List<Task>> watchTasks(String title) =>
      (select(tasks)..where((task) => task.title.equals(title))).watch();

  Future<int> addTask(Task task) => into(tasks).insert(task);

  Future<int> deleteTitle(String title) =>
      (delete(tasks)..where((task) => task.title.equals(title))).go();

  Future<int> deleteTask(Task task) => delete(tasks).delete(task);
}
