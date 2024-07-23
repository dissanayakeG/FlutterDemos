import 'package:demo_app/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Todo {
  final int id;
  final String title;
  final String description;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, Object> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description}';
  }

  static Future<void> insert(Todo todo) async {
    final db = await DatabaseHelper().database;

    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Todo>> getAllTodos() async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> todos = await db.query("todos");

    return [
      for (final {
            'id': id as int,
            'title': title as String,
            'description': description as String,
          } in todos)
        Todo(id: id, title: title, description: description),
    ];
  }

  static Future<void> update(Todo todo) async {
    final db = await DatabaseHelper().database;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<void> delete(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('todos', where: 'id=?', whereArgs: [id]);
  }
}
