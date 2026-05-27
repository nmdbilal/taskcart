import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/core/usecase/usecase.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';

class GetTodosUsecase implements Usecase<List<TodoEntity>, NoParams> {
  final TodoRepo repo;
  GetTodosUsecase({required this.repo});

  @override
  Future<Either<Failure, List<TodoEntity>>> call(NoParams params) {
    return repo.getAllTodos();
  }
}

class NoParams {}