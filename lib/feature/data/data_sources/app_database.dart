import 'package:bloc_pattern/feature/data/models/todo_model.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableTodo = 'todo';
const String columnId = 'id';
const String columnLabel = 'label';
const String columnDescription = 'description';
const String columnCreatedDate = 'created_date';
const String DB_NAME = "todo.db";

class AppDatabase {
  late Database db;

  AppDatabase({required this.db});

  static Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnLabel text not null,
  $columnDescription text not null,
  $columnCreatedDate integer not null)
''');
    });
    return db;
  }

  Future<TodoEntity> insert(TodoModel todoModel) async {
    int id = await db.insert(tableTodo, todoModel.toMap());
    return todoModel.copyWith(id: id);
  }

  Future<TodoEntity?> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnLabel, columnDescription, columnCreatedDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoModel.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<TodoEntity>> getAllTodo() async {
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId, columnLabel, columnDescription, columnCreatedDate],
    );
    if (maps.isNotEmpty) {
      return maps
          .map((entry) => TodoModel.fromMap(entry as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel todoModel) async {
    return await db.update(tableTodo, todoModel.toMap(),
        where: '$columnId = ?', whereArgs: [todoModel.id]);
  }

  Future close() async => db.close();
}
