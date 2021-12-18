// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final String title;
  final String item;
  final bool isDone;
  Task({required this.title, required this.item, required this.isDone});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      item: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item'])!,
      isDone: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_done'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['item'] = Variable<String>(item);
    map['is_done'] = Variable<bool>(isDone);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      title: Value(title),
      item: Value(item),
      isDone: Value(isDone),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      title: serializer.fromJson<String>(json['title']),
      item: serializer.fromJson<String>(json['item']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'item': serializer.toJson<String>(item),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  Task copyWith({String? title, String? item, bool? isDone}) => Task(
        title: title ?? this.title,
        item: item ?? this.item,
        isDone: isDone ?? this.isDone,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('title: $title, ')
          ..write('item: $item, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, item, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.title == this.title &&
          other.item == this.item &&
          other.isDone == this.isDone);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> title;
  final Value<String> item;
  final Value<bool> isDone;
  const TasksCompanion({
    this.title = const Value.absent(),
    this.item = const Value.absent(),
    this.isDone = const Value.absent(),
  });
  TasksCompanion.insert({
    required String title,
    required String item,
    required bool isDone,
  })  : title = Value(title),
        item = Value(item),
        isDone = Value(isDone);
  static Insertable<Task> custom({
    Expression<String>? title,
    Expression<String>? item,
    Expression<bool>? isDone,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (item != null) 'item': item,
      if (isDone != null) 'is_done': isDone,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? title, Value<String>? item, Value<bool>? isDone}) {
    return TasksCompanion(
      title: title ?? this.title,
      item: item ?? this.item,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('title: $title, ')
          ..write('item: $item, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _itemMeta = const VerificationMeta('item');
  late final GeneratedColumn<String?> item = GeneratedColumn<String?>(
      'item', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  late final GeneratedColumn<bool?> isDone = GeneratedColumn<bool?>(
      'is_done', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_done IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [title, item, isDone];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    } else if (isInserting) {
      context.missing(_isDoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title, item};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}
