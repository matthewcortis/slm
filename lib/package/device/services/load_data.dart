import 'dart:convert';
import 'package:flutter/services.dart';
import '../../model/device_model.dart';

Future<CategoryModel> loadCategoryById(int id) async {
  // Đọc file JSON
  final jsonString = await rootBundle.loadString('assets/data/devices.json');
  final data = json.decode(jsonString);

  // Lấy list categories
  final categories = data['categories'] as List;

  // Tìm category theo id
  final categoryData = categories.firstWhere(
    (cat) => cat['id'] == id,
    orElse: () => throw Exception('Không tìm thấy danh mục với id = $id'),
  );

  // Chuyển sang model
  return CategoryModel.fromJson(categoryData);
}
