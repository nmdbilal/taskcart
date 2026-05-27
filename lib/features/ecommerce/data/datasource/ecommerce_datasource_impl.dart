import 'package:taskcart/features/ecommerce/data/datasource/ecommerce_datasource.dart';
import 'package:taskcart/features/ecommerce/data/model/banner_model.dart';
import 'package:taskcart/features/ecommerce/data/model/category_model.dart';
import 'package:taskcart/features/ecommerce/data/model/product_model.dart';

class EcommerceDatasourceImpl implements EcommerceDatasource {
  @override
  List<BannerModel> getBanners() => [
    BannerModel(
      id: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800',
      title: 'Fresh Groceries',
      subtitle: 'Up to 30% off today',
      bgColor: '#4CAF50',
    ),
    BannerModel(
      id: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1608686207856-001b95cf60ca?w=800',
      title: 'Organic Fruits',
      subtitle: 'Farm fresh daily',
      bgColor: '#FF9800',
    ),
    BannerModel(
      id: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=800',
      title: 'Dairy Products',
      subtitle: 'Best quality guaranteed',
      bgColor: '#2196F3',
    ),
  ];

  @override
  List<CategoryModel> getCategories() => [
    CategoryModel(id: 1, name: 'Fruits', icon: '🍎'),
    CategoryModel(id: 2, name: 'Vegetables', icon: '🥦'),
    CategoryModel(id: 3, name: 'Dairy', icon: '🥛'),
    CategoryModel(id: 4, name: 'Bakery', icon: '🍞'),
    CategoryModel(id: 5, name: 'Meat', icon: '🥩'),
    CategoryModel(id: 6, name: 'Beverages', icon: '🧃'),
    CategoryModel(id: 7, name: 'Snacks', icon: '🍿'),
    CategoryModel(id: 8, name: 'Frozen', icon: '🧊'),
  ];

  @override
  List<ProductModel> getProducts() => [
    ProductModel(
      id: 1,
      name: 'Red Apples',
      image: 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400',
      price: 149.0,
      rating: 4.5,
      unit: 'kg',
    ),
    ProductModel(
      id: 2,
      name: 'Broccoli',
      image:
          'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
      price: 45.0,
      rating: 4.2,
      unit: 'bunch',
    ),
    ProductModel(
      id: 3,
      name: 'Fresh Milk',
      image: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
      price: 32.0,
      rating: 4.8,
      unit: 'litre',
    ),
    ProductModel(
      id: 4,
      name: 'Whole Bread',
      image:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      price: 85.0,
      rating: 4.3,
      unit: 'loaf',
    ),
    ProductModel(
      id: 5,
      name: 'Bananas',
      image:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
      price: 60.0,
      rating: 4.6,
      unit: 'bunch',
    ),
    ProductModel(
      id: 6,
      name: 'Cheddar Cheese',
      image: 'https://images.unsplash.com/photo-1552767059-ce182ead6c1b?w=400',
      price: 120.0,
      rating: 4.4,
      unit: '200g',
    ),
    ProductModel(
      id: 7,
      name: 'Orange Juice',
      image:
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
      price: 65.0,
      rating: 4.7,
      unit: 'litre',
    ),
    ProductModel(
      id: 8,
      name: 'Chicken Breast',
      image:
          'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400',
      price: 240.0,
      rating: 4.5,
      unit: 'kg',
    ),
  ];
}
