import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';

abstract interface class TodoRepo {
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, int>> addTodo(TodoEntity todo);
  Future<Either<Failure, int>> updateTodo(TodoEntity todo);
  Future<Either<Failure, int>> deleteTodo(int id);
}