import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskcart/features/todo/data/datasource/todo_datasource.dart';
import 'package:taskcart/features/todo/data/model/todo_model.dart';

class TodoDatasourceImpl implements TodoDatasource {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'todos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final db = await database;
    final maps = await db.query('todos', orderBy: 'createdAt DESC');
    return maps.map((m) => TodoModel.fromMap(m)).toList();
  }

  @override
  Future<int> insertTodo(TodoModel todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> updateTodo(TodoModel todo) async {
    final db = await database;
    return await db.update('todos', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  @override
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}