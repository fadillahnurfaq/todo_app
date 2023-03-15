import 'package:sqflite/sqflite.dart';
import '../models/todo_model.dart';

class TodoDb {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "todo";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}todo.db';
        _db = await openDatabase(path, version: _version,
            onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE $_tableName("
            "ID TEXT PRIMARY KEY, "
            "TITLE TEXT NOT NULL, "
            "DESCRIPTION TEXT NOT NULL, "
            "CREATEDAT TEXT NOT NULL, "
            "DEADLINE TEXT, "
            "IMAGE TEXT)",
          );
        });
      } catch (e) {}
    }
  }

  static Future<int> insert(TodoModel todoModel) async {
    return await _db?.insert(_tableName, todoModel.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<int> updateTodo(TodoModel todo, String id) async {
    return await _db!
        .update(_tableName, todo.toJson(), where: 'ID = ?', whereArgs: [id]);
  }

  static Future<int> deletTodo(String id) async {
    return await _db!.delete(_tableName, where: 'ID = ?', whereArgs: [id]);
  }
}
