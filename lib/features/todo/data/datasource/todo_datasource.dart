import 'package:taskcart/features/todo/data/model/todo_model.dart';

abstract interface class TodoDatasource {
  Future<List<TodoModel>> getAllTodos();
  Future<int> insertTodo(TodoModel todo);
  Future<int> updateTodo(TodoModel todo);
  Future<int> deleteTodo(int id);
}