import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/product_device_model.dart';

class ProductDeviceCard extends StatelessWidget {
  final ProductDeviceModel product;
  const ProductDeviceCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26D1D1D1),
            blurRadius: 34,
            offset: Offset(0, 15),
          ),
          BoxShadow(
            color: Color(0x21D1D1D1),
            blurRadius: 61,
            offset: Offset(0, 61),
          ),
          BoxShadow(
            color: Color(0x14D1D1D1),
            blurRadius: 82,
            offset: Offset(0, 137),
          ),
          BoxShadow(
            color: Color(0x0DD1D1D1),
            blurRadius: 98,
            offset: Offset(0, 244),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ---------------- ẢNH ----------------
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Image.asset(
                  product.image,
                  width: 271,
                  height: 130,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 271,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const RadialGradient(
                      center: Alignment.center,
                      radius: 0.75,
                      colors: [
                        Colors.transparent,
                        Color.fromRGBO(0, 0, 0, 0.2),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      product.quantityTag,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ---------------- THÔNG TIN ----------------
          SizedBox(
            width: 271,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag bảo hành
                  Container(
                  width: double.infinity,
                  height: 28,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3), // background: #F3F3F3
                    borderRadius: BorderRadius.circular(100), // radius: 100px
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ✅ SVG icon
                      SvgPicture.asset(
                        'assets/icons/new-releases.svg',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4), // gap: 4px
                      Text(
                        product.warranty,
                        style: const TextStyle(
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF4F4F4F),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF4F4F4F),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFFEE4037),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Công suất:',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                    Text(
                      product.power,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Công nghệ:',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                    Text(
                      product.technology,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ---------------- NÚT ----------------
          Container(
            width: 271,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E6), // ✅ nền xám nhạt giống hình
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26D1D1D1),
                  blurRadius: 34,
                  offset: Offset(0, 15),
                ),
                BoxShadow(
                  color: Color(0x21D1D1D1),
                  blurRadius: 61,
                  offset: Offset(0, 61),
                ),
                BoxShadow(
                  color: Color(0x14D1D1D1),
                  blurRadius: 82,
                  offset: Offset(0, 137),
                ),
                BoxShadow(
                  color: Color(0x0DD1D1D1),
                  blurRadius: 98,
                  offset: Offset(0, 244),
                ),
                BoxShadow(
                  color: Color(0x00D1D1D1),
                  blurRadius: 107,
                  offset: Offset(0, 382),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Xem chi tiết',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFFEE4037), // ✅ chữ đỏ
                    ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/circle-arrow-right-02-round.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFEE4037), // ✅ icon đỏ
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
