import 'package:taskcart/features/ecommerce/data/model/banner_model.dart';
import 'package:taskcart/features/ecommerce/data/model/category_model.dart';
import 'package:taskcart/features/ecommerce/data/model/product_model.dart';

abstract interface class EcommerceDatasource {
  List<BannerModel> getBanners();
  List<CategoryModel> getCategories();
  List<ProductModel> getProducts();
}