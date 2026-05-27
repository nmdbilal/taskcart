import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/core/usecase/usecase.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';

class UpdateTodoUsecase implements Usecase<int, TodoEntity> {
  final TodoRepo repo;
  UpdateTodoUsecase({required this.repo});

  @override
  Future<Either<Failure, int>> call(TodoEntity params) {
    return repo.updateTodo(params);
  }
}