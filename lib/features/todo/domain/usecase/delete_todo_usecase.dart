import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/core/usecase/usecase.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';

class DeleteTodoUsecase implements Usecase<int, int> {
  final TodoRepo repo;
  DeleteTodoUsecase({required this.repo});

  @override
  Future<Either<Failure, int>> call(int params) {
    return repo.deleteTodo(params);
  }
}