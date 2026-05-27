import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/features/ecommerce/domain/entities/banner_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/category_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';

abstract interface class EcommerceRepo {
  Future<Either<Failure, List<BannerEntity>>> getBanners();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}