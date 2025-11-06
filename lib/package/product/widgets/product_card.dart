import 'package:flutter/material.dart';
import '../../model/ProductModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// card home
class ProductItemCard extends StatelessWidget {
  final ProductHotModel product;
  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
          rootNavigator: false,
        ).pushNamed('/detail-product');
      },

      child: Container(
        width: scale(188),
        height: scale(389),

        padding: EdgeInsets.all(scale(12)),
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
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- IMAGE + TYPE TAG ---
            Stack(
              children: [
                Image.asset(
                  product.image,
                  width: 167,
                  height: 167,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 167,
                  height: 157,
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
                  top: scale(12),
                  left: scale(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: scale(8),
                      vertical: scale(4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      product.type,
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w500,
                        fontSize: scale(10),
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: scale(12)),

            // --- TEXT CONTENT ---
            SizedBox(
              width: scale(167),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                      fontSize: scale(14),
                      height: 20 / 14,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                  SizedBox(height: scale(4)),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: scale(16),
                      height: 24 / 16,
                      color: const Color(0xFFEE4037),
                    ),
                  ),
                  SizedBox(height: scale(4)),
                  Container(
                    width: scale(161),
                    height: scale(26),
                    padding: EdgeInsets.symmetric(
                      horizontal: scale(8),
                      vertical: scale(4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/new-releases.svg',
                          width: scale(18),
                          height: scale(18),
                        ),
                        SizedBox(width: scale(4)),
                        Text(
                          product.saving,
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w400,
                            fontSize: scale(8),
                            height: 12 / 9,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: scale(12)),

            // --- BUTTON ---
            Container(
              width: 167,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6), // Nền xám (Gray-G2)
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
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w500, // Medium (≈510)
                        fontSize: 16,
                        height: 24 / 16, // line-height: 24px
                        color: Color(0xFFEE4037), // Đỏ thương hiệu
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/circle-arrow-right-02-round.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFEE4037),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
