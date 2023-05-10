import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class Tasks extends Table{
  IntColumn get id=>integer().autoIncrement()();
  TextColumn get name=>text()();
  DateTimeColumn get dueDate=>dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

}

@UseMoor(tables:[Tasks])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks()=>select(tasks).get();
  Stream<List<Task>> watchAllTasks()=>select(tasks).watch();
  Future<int> insertTask(TasksCompanion task) =>into(tasks).insert(task);
  Future<bool> updateTask(Task task) =>update(tasks).replace(task);
  Future<int> deleteTask(Task task) =>delete(tasks).delete(task);

}
