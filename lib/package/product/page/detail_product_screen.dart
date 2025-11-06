
import 'package:flutter/material.dart';
import '../widgets/top_bar_detail.dart';
import '../widgets/device_section.dart';

import '../../home/services/product_category_model.dart';
import '../../home/services/load_product.dart'; 
import '../../product/widgets/other_materials_section.dart';
class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ProductCategoryModel>(
        future: loadAllProducts(), // ✅ Lấy dữ liệu từ JSON
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryData = snapshot.data!;
          final deviceProducts = categoryData.deviceProducts; // ✅ Lấy danh sách thiết bị

          return Stack(
            children: [
              // --- Nội dung cuộn ---
              SingleChildScrollView(
                child: Column(
                  children: [
                    // --- Ảnh sản phẩm ---
                    SizedBox(
                      width: width,
                      height: 355,
                      child: const ProductImagePreview(),
                    ),

                    // --- Các phần chi tiết ---
                    ComboDetailCard(),
                    const SizedBox(height: 10),
                    ComboDetailInfo(),
                    const SizedBox(height: 10),

                    // --- Danh mục thiết bị ---
                    DeviceSection(deviceProducts: deviceProducts),

                      const SizedBox(height: 10),
                      OtherMaterialsSection()
                      

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
