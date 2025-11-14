import 'dart:ui';
import 'package:flutter/material.dart';

class WarrantyItemCard extends StatelessWidget {
  final String image;
  final String statusText;
  final String productName;
  final String activeDate;
  final String duration;
  final String endDate;
  final double progress;

  const WarrantyItemCard({
    super.key,
    required this.image,
    required this.statusText,
    required this.productName,
    required this.activeDate,
    required this.duration,
    required this.endDate,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(402),
      padding: EdgeInsets.fromLTRB(
        scale(16), 
        scale(8), 
        scale(16),
        scale(8), 
      ),
      decoration: BoxDecoration(
        color: const Color(0x33B5B5B5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// IMAGE
              SizedBox(
                width: scale(74),
                height: scale(74),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        image,
                        width: scale(74),
                        height: scale(74),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.75,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(0, 0, 0, 0.25),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: scale(12)),

              /// CONTENT
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(scale(8)),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Status Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: scale(10),
                          vertical: scale(2),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x332ECC71),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFF2ECC71)),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: scale(10),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProDisplay',
                            color: const Color(0xFF2ECC71),
                          ),
                        ),
                      ),

                      SizedBox(height: scale(4)),

                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: scale(14),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SFProDisplay',
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),

                      SizedBox(height: scale(4)),

                      Text(
                        "Ngày kích hoạt: $activeDate",
                        style: TextStyle(
                          fontSize: scale(12),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFProDisplay',
                          color: const Color(0xFF7B7B7B),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thời gian: $duration",
                            style: TextStyle(
                              fontSize: scale(12),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SFProDisplay',
                              color: const Color(0xFF7B7B7B),
                            ),
                          ),
                          Text(
                            "Đến hết: $endDate",
                            style: TextStyle(
                              fontSize: scale(12),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SFProDisplay',
                              color: const Color(0xFF7B7B7B),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: scale(6)),

                      /// PROGRESS BAR
                      Container(
                        width: double.infinity,
                        height: scale(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E8E8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getProgressGradientColor(progress),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color getProgressGradientColor(double progress) {
  return Color.lerp(
    const Color(0xFF2ECC71),
    const Color(0xFFEE4037),
    progress.clamp(0, 1),
  )!;
}
