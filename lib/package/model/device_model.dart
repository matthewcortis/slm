import '../device/model/product_device_model.dart';

class CategoryModel {
  final int id;
  final String categoryName;
  final String categoryIcon;
  final String categoryDes;
  final List<ProductDeviceModel> products;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryDes,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      categoryIcon: json['category_icon'],
      categoryDes: json['category_des'],
      products: (json['products'] as List)
          .map((p) => ProductDeviceModel.fromJson(p))
          .toList(),
    );
  }
}
