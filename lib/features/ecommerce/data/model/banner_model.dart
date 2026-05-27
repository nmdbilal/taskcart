import 'package:taskcart/features/ecommerce/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.id,
    required super.imageUrl,
    required super.title,
    required super.subtitle,
    required super.bgColor,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      imageUrl: json['imageUrl'] ?? "",
      title: json['title'] ?? "",
      subtitle: json['subtitle'] ?? "",
      bgColor: json['bgColor'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'bgColor': bgColor,
    };
  }
}