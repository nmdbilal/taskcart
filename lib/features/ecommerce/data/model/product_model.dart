import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.image,
    required super.price,
    required super.rating,
    required super.unit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      unit: json['unit'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'rating': rating,
      'unit': unit,
    };
  }
}