import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/core/usecase/usecase.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';

class AddTodoUsecase implements Usecase<int, TodoEntity> {
  final TodoRepo repo;
  AddTodoUsecase({required this.repo});

  @override
  Future<Either<Failure, int>> call(TodoEntity params) {
    return repo.addTodo(params);
  }
}