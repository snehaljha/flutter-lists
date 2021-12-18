import 'package:moor_flutter/moor_flutter.dart';

class Tasks extends Table {
  TextColumn get title => text()();
  TextColumn get item => text()();
  BoolColumn get isDone => boolean()();

  @override
  Set<Column> get primaryKey => {title ,item};
}