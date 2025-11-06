import 'package:flutter/material.dart';
import '../model/product_device_model.dart';
import '../widgets/product_device_card.dart'; // 🔁 import đúng đường dẫn tới card

class AllProductDeviceScreen extends StatelessWidget {
  final List<ProductDeviceModel> products;
  final String title; 
   final VoidCallback onBack; 
  const AllProductDeviceScreen({super.key, required this.products, required this.title,required this.onBack, });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: scale(24)),

            // --- Header: nút back + tiêu đề ---
            Stack(
              alignment: Alignment.center,
              children: [
                // Nút quay lại
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: onBack,
                    child: Container(
                      width: scale(48),
                      height: scale(48),
                      margin: EdgeInsets.only(left: scale(14)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E6E6),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
                          BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
                          BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
                          BoxShadow(color: Color(0x0DD1D1D1), blurRadius: 98, offset: Offset(0, 244)),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF4F4F4F)),
                    ),
                  ),
                ),

                // Tiêu đề
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600, // Semibold ~590
                    fontSize: scale(20),
                    height: 25 / 20,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),

            SizedBox(height: scale(24)),

            // --- GridView 2 cột hiển thị card ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(16)),
                  child: GridView.builder(
                    shrinkWrap: true, // ✅ Quan trọng để không chiếm toàn bộ chiều cao
                    physics: const NeverScrollableScrollPhysics(), // ✅ Ngăn GridView cuộn độc lập
                    clipBehavior: Clip.none, 
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: scale(16),
                      crossAxisSpacing: scale(16),
                      childAspectRatio: 0.47,
                    ),
                    itemBuilder: (context, index) {
                      return ProductDeviceCard(product: products[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
