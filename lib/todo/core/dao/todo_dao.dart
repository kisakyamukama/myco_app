import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:myco/constants/constants.dart';
import 'package:myco/todo/core/database/database.dart';
import 'package:myco/todo/core/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Todo>> getTodos(
      {required List<String> columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>>? result;
    // return unsynched
    if (query != null && query.contains("is_synched")) {
      result =
          await db.query(todoTABLE, columns: columns, where: 'is_synched = 0');
    } else if (query != null || query != "") {
      // if (query.isNotEmpty) {
      result = await db.query(todoTABLE,
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]);
      // }
    } else {
      result = await db.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  //Update Todo record
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db.update(todoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(todoTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      todoTABLE,
    );

    return result;
  }

  void alterTable(String tableName, String columns) async {
    final db = await dbProvider.database;
    String sql = "ALTER TABLE $tableName  ADD COLUMN $columns";
    db.execute(sql);
  }

  Future synchronize() async {
    try {
      // alterTable('Todo', 'is_synched INTEGER default 0');
      List<Todo> todos = await getTodos(query: "is_synched = 0", columns: []);
      debugPrint('${todos.length}');
      for (Todo todo in todos) {
        // store online

        var body = jsonEncode(<String, dynamic>{
          "id": todo.id,
          "description": todo.description,
          "isDone": todo.isDone
        });

        await storeDataRemotely(body: body).then((response) async {
          debugPrint(response.body);
          if (response.statusCode == 200) {
            // update todo Status
            await updateTodo(Todo(
                id: todo.id,
                description: todo.description,
                isDone: todo.isDone,
                isSynchronized: true));
          } else {
            throw Exception(jsonDecode(response.body)['message']);
          }
        });
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future storeDataRemotely({required var body}) async {
    return await http.post(Uri.parse(localUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: body);
  }
}
