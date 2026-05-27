import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/features/ecommerce/data/datasource/ecommerce_datasource.dart';
import 'package:taskcart/features/ecommerce/domain/entities/banner_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/category_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';
import 'package:taskcart/features/ecommerce/domain/repository/ecommerce_repo.dart';

class EcommerceRepoImpl implements EcommerceRepo {
  final EcommerceDatasource datasource;
  EcommerceRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async {
    try {
      return Right(datasource.getBanners());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      return Right(datasource.getCategories());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      return Right(datasource.getProducts());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
