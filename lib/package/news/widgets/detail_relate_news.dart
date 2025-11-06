import 'package:flutter/material.dart';
import '../../product/widgets/product_card_temp.dart';
import '../../model/product_device_model.dart';

class RelatedNewsSection extends StatelessWidget {
  final List<ProductDeviceModel> productsDevice;

  const RelatedNewsSection({super.key, required this.productsDevice});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(398),
      padding: EdgeInsets.only(top: scale(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Tiêu đề "Tin tức liên quan" =====
          Padding(
            padding: EdgeInsets.symmetric(horizontal: scale(4)),
            child: Text(
              'Tin tức liên quan',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w600, // Semibold ~590
                fontSize: scale(16),
                height: 1.5,
                color: const Color(0xFF4F4F4F), // Gray-G5
              ),
            ),
          ),
          SizedBox(height: scale(12)),

          // ===== Danh sách card sản phẩm =====
          SizedBox(
            width: scale(398),
               height: scale(399),
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: productsDevice.length,
              separatorBuilder: (_, __) => SizedBox(width: scale(17)),
              itemBuilder: (context, index) {
                return ProductDeviceCard(product: productsDevice[index]);
              },
            ),
          ),


          SizedBox(height: 80,)
        ],
      ),
    );
  }
}
