import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}