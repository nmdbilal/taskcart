import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/features/todo/data/datasource/todo_datasource.dart';
import 'package:taskcart/features/todo/data/model/todo_model.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoDatasource datasource;
  TodoRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodos() async {
    try {
      final result = await datasource.getAllTodos();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> addTodo(TodoEntity todo) async {
    try {
      final result = await datasource.insertTodo(TodoModel.fromEntity(todo));
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateTodo(TodoEntity todo) async {
    try {
      final result = await datasource.updateTodo(TodoModel.fromEntity(todo));
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      final result = await datasource.deleteTodo(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}