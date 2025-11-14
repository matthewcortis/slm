import 'dart:ui';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;
    final List<SpecItem> specs = [
      SpecItem("1. Công nghệ:", "N-type Double Glass Bifacial Modules"),
      SpecItem("2. Thương hiệu:", "JA Solar"),
      SpecItem("3. Công suất:", "600Wp"),
      SpecItem("4. Khối lượng:", "31.8kg"),
      SpecItem("5. Kích thước:", "2278+-2mm x 1134+-2mm x 30+-1mm"),
      SpecItem("6. Hiệu suất chuyển đổi:", "23.2%"),
      SpecItem("7. Bảo hành:", "12 năm vật lý, 25 năm hiệu suất"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: CustomScrollView(
        slivers: [
          /// --- Header với ảnh sản phẩm ---
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: scale(355),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/product.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: scale(34),
                    left: scale(14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(256),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: scale(48),
                          height: scale(48),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E6E6).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(256),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 20, color: Color.fromARGB(221, 255, 0, 0)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: scale(12),
                    right: scale(14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: scale(12),
                            vertical: scale(4),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x33B5B5B5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            '1/13 ảnh',
                            style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontSize: scale(13),
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// --- Khối nội dung ---
          SliverToBoxAdapter(
            child: Container(
              width: width,
              padding: EdgeInsets.all(scale(16)),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông số kỹ thuật Tấm Pin JA 600W JAM72D40 600/MB ...',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: scale(18),
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                  SizedBox(height: scale(8)),
                  Text(
                    '49.900.000 đ',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                      fontSize: scale(24),
                      color: const Color(0xFFEE4037),
                    ),
                  ),
                  SizedBox(height: scale(24)),

                  /// Button Datasheet
                  Container(
                    width: width,
                    height: scale(40),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download_rounded,
                            color: Color(0xFFEE4037), size: 20),
                        SizedBox(width: scale(8)),
                        Text(
                          'Datasheet',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500,
                            fontSize: scale(16),
                            color: const Color(0xFFEE4037),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: scale(12)),

                  /// Button liên hệ
                  Container(
                    width: width,
                    height: scale(40),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE4037),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x26D1D1D1),
                            blurRadius: 34,
                            offset: Offset(0, 15))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Liên hệ ngay',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: scale(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: scale(40)),
                ],
              ),
            ),
          ),

          /// "Thông tin chi tiết"
          SliverToBoxAdapter(
            child: ProductSpecsSection(specs: specs),
          ),
        ],
      ),
    );
  }
}

class SpecItem {
  final String title;
  final String value;
  SpecItem(this.title, this.value);
}

class ProductSpecsSection extends StatelessWidget {
  final List<SpecItem> specs;
  const ProductSpecsSection({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: width,
      padding: EdgeInsets.all(scale(16)),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          ...specs.map(
            (item) => Container(
              padding: EdgeInsets.symmetric(vertical: scale(12)),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        fontSize: scale(12),
                        height: 18 / 12,
                        color: const Color(0xFF848484),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      item.value,
                      textAlign: TextAlign.right,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        fontSize: scale(12),
                        height: 18 / 12,
                        color: const Color(0xFF4F4F4F),
                      ),
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
