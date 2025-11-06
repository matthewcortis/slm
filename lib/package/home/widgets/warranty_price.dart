import 'dart:ui';
import 'package:flutter/material.dart';

class ContractValueCard extends StatelessWidget {
  final String deliveryDate;   // Ngày bàn giao
  final String totalValue;     // Tổng giá trị hợp đồng
  final VoidCallback? onView;  // Nhấn nút xem chi tiết (nếu cần)

  const ContractValueCard({
    super.key,
    required this.deliveryDate,
    required this.totalValue,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Center(
      child: Container(
        width: scale(398),
        height: scale(93),
        padding: EdgeInsets.all(scale(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF3F3F3), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000), // #0000001F
              blurRadius: 20,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// LEFT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: scale(8),
                    vertical: scale(4),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x33E6E6E6),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xFFF3F3F3)),
                  ),
                  child: Text(
                    'Ngày bàn giao: $deliveryDate',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w400,
                      fontSize: scale(10),
                      height: 18 / 12,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                ),
                SizedBox(height: scale(8)),
                Text(
                  'Tổng giá trị hợp đồng',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 20 / 14,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),

            /// RIGHT
            GestureDetector(
              onTap: onView,
              child: Row(
                children: [
                  Text(
                    totalValue, // <-- DYNAMIC
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: scale(24),
                      height: 30 / 24,
                      color: const Color(0xFFEE4037),
                    ),
                  ),
                  SizedBox(width: scale(6)),
                  const Icon(
                    Icons.visibility_outlined,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
