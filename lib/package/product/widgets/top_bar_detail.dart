import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductImagePreview extends StatelessWidget {
  const ProductImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Image ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/product.png', // đổi thành ảnh của bạn
              fit: BoxFit.contain,
            ),
          ),

          // --- Back Glass Button ---
          Positioned(
            top: 86,
            left: 14,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(256),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(256),
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
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black87,
                      size: 18,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),

          // --- Glass Label “1/13 ảnh” ---
          Positioned(
            bottom: width * 0.1,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x33B5B5B5), // #B5B5B533
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: const Text(
                    '1/13 ảnh',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComboDetailCard extends StatelessWidget {
  const ComboDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(430),
      height: scale(358),
      padding: EdgeInsets.all(scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
      
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Tiết kiệm / tháng ---
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/new-releases.svg', // đường dẫn tới file SVG của bạn
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF4F4F4F),
                  BlendMode.srcIn,
                ),
              ),

              SizedBox(width: scale(4)),
              Text(
                'Tiết kiệm/ tháng: 5.000.000 đ',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w400,
                  fontSize: scale(13),
                  height: 20 / 13,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ],
          ),
          SizedBox(height: scale(8)),

          // --- Tiêu đề ---
          Text(
            'Hệ Hybrid 5kWp 1 pha - Lưu trữ 5.12kWh Cao Cấp',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: scale(16),
              height: 22 / 16,
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(8)),

          // --- Giá ---
          Text(
            '49.900.000 đ',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w700,
              fontSize: scale(24),
              height: 30 / 24,
              color: const Color(0xFFEE4037),
            ),
          ),
          SizedBox(height: scale(12)),

          // --- Hóa đơn tiền điện ---
          Container(
            width: scale(295),
            height: scale(36),
            padding: EdgeInsets.symmetric(
              horizontal: scale(12),
              vertical: scale(8),
            ),
            decoration: BoxDecoration(
              color: const Color(0x33E6E6E6),
              borderRadius: BorderRadius.circular(scale(12)),
            ),
            child: Center(
              child: Text(
                'Phù hợp cho hoá đơn tiền điện 1 - 2 triệu',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w500,
                  fontSize: scale(13),
                  height: 20 / 13,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ),
          ),
          SizedBox(height: scale(16)),

          // --- Mô tả ---
          Text(
            'Hệ thống điện mặt trời Hybrid, có bao gồm Pin lưu trữ Lithium, nên có thể vận hành độc lập với nguồn lưới điện.',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w400,
              fontSize: scale(14),
              height: 20 / 14,
              color: const Color(0xFF848484),
            ),
          ),
          SizedBox(height: scale(24)),

          // --- 2 nút ---
          Row(
            children: [
              // --- Nút "Thông tin báo giá" ---
              Expanded(
                child: Container(
                  height: scale(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6), // var(--Gray-G2)
                    borderRadius: BorderRadius.circular(scale(12)),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/document-validation.svg',
                        width: 18,
                        height: 18,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFEE4037),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: scale(10)),
                      Text(
                        'Thông tin báo giá',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: scale(14),
                          color: const Color(0xFFEE4037),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: scale(12)), // khoảng cách giữa 2 nút
          // --- Nút "Liên hệ ngay" ---
          Container(
            width: scale(398),
            height: scale(40),
            decoration: BoxDecoration(
              color: const Color(0xFFEE4037), // var(--Primary-P4)
              borderRadius: BorderRadius.circular(scale(12)),
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
              child: Text(
                'Liên hệ ngay',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w600,
                  fontSize: scale(14),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ComboDetailInfo extends StatelessWidget {
  const ComboDetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(430),
      height: scale(228),
      padding: EdgeInsets.all(scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        
        boxShadow: const [
          BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
          BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
          BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Tiêu đề ---
          Text(
            'Thông tin chi tiết',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: scale(16),
              height: 24 / 16,
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(12)),

          // --- Bảng thông tin ---
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRow('Công suất PV:', '50kW'),
                _buildRow('Biến tần solis:', '50kW'),
                _buildRow('Lưu trữ Dyness:', '50kW'),
                _buildRow('Sản lượng:', '350-450 kWh/tháng'),
                _buildRow('Hoàn vốn:', '3 năm 6 tháng'),
                _buildRow('Diện tích lắp đặt:', '21m2'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cột trái
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 20 / 14,
              color: Color(0xFF848484), // var(--Gray-G4)
            ),
          ),
          // Cột phải
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 20 / 14,
              color: Color(0xFF4F4F4F), // var(--Gray-G5)
            ),
          ),
        ],
      ),
    );
  }
}