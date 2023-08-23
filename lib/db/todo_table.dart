import 'package:sqflite/sqflite.dart';
import 'package:todo_app/db/todo_database.dart';

import '../model/todo.dart';

class TodoTable {
  static const TABLE_NAME = "todo";
  static const CREATE_TABLE_QUERY = '''
      CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
      )
  ''';
  static const DROP_TABLE_QUERY = '''
      DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  Future<void> insertTodo(Todo todo) async {
    final db = TodoDatabase.instance.database;
    await db?.insert(TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = TodoDatabase.instance.database;
    await db?.delete(TABLE_NAME, where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> selectAllTodo() async {
    final db = TodoDatabase.instance.database;
    try {
      final List<Map<String, dynamic>>? todoexist = await db?.query('todo');
    } catch (e) {
      print(e.toString());
      await db?.execute(DROP_TABLE_QUERY);
      await db?.execute(CREATE_TABLE_QUERY);
    }

    final List<Map<String, dynamic>>? todos = await db?.query('todo');
    if (todos == null) return List.empty();
    return List.generate(todos.length, (index) {
      return Todo.fromData(todos[index]['id'], todos[index]['content']);
    });
  }
}
