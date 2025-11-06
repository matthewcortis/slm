import 'package:flutter/material.dart';
import '../../home/services/product_category_model.dart';
import '../services/load_product.dart';
import '../widgets/app_bar_home.dart';
import '../widgets/list_product.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: FutureBuilder<ProductCategoryModel>(
        future: loadAllProducts(), // ✅ cần đảm bảo tên hàm này trùng với trong file load_product.dart
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryData = snapshot.data!;
          final hotProducts = categoryData.hotProducts;
          final deviceProducts = categoryData.deviceProducts;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  const SolarHeaderFullCard(),
                  const SizedBox(height: 24),
                  const ContractValueCard(),
                  const SizedBox(height: 24),
                  // 🔥 Section 1: Sản phẩm bán chạy
                  BestSellerSection(products: hotProducts),
                  const SizedBox(height: 24),
                  // ☀️ Section 2: Thiết bị quang năng
                  ProductDevice(products_device: deviceProducts)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
