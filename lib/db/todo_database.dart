import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/db/todo_table.dart';

class TodoDatabase {
  static const DB_NAME = "todo1.db";
  static const DB_VERSION = 1;
  static Database? _database;

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  Database? get database => _database;

  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: (db, version) {
        initScripts.forEach((element) async {
          await db.execute(element);
        });
      },
      onUpgrade: (db, oldVersion, newVersion) {
        migrationScripts.forEach((element) async {
          await db.execute(element);
        });
      },
    );
  }
}
