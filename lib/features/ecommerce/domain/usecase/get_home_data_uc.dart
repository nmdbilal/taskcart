import 'package:dartz/dartz.dart';
import 'package:taskcart/core/errors/failures.dart';
import 'package:taskcart/core/usecase/usecase.dart';
import 'package:taskcart/features/ecommerce/domain/entities/banner_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/category_entity.dart';
import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';
import 'package:taskcart/features/ecommerce/domain/repository/ecommerce_repo.dart';

class HomeData {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  HomeData({required this.banners, required this.categories, required this.products});
}

class GetHomeDataUsecase implements Usecase<HomeData, NoParams> {
  final EcommerceRepo repo;
  GetHomeDataUsecase({required this.repo});

  @override
  Future<Either<Failure, HomeData>> call(NoParams params) async {
    final banners = await repo.getBanners();
    final categories = await repo.getCategories();
    final products = await repo.getProducts();

    return banners.fold(
          (f) => Left(f),
          (b) => categories.fold(
            (f) => Left(f),
            (c) => products.fold(
              (f) => Left(f),
              (p) => Right(HomeData(banners: b, categories: c, products: p)),
        ),
      ),
    );
  }
}

class NoParams {}