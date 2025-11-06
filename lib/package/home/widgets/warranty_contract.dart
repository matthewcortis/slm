import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WarrantyContractCard extends StatelessWidget {
  const WarrantyContractCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: scale(402),
            padding: EdgeInsets.all(scale(16)),
            decoration: BoxDecoration(
              color: const Color(0x33F3F3F3), // #F3F3F333
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE0E0E0), // xám nhạt đẹp
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ==== TITLE ====
                Text(
                  "Hợp đồng bảo hành",
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: scale(18),
                    height: 28 / 18,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),

                SizedBox(height: scale(12)),

                /// ==== CONTENT FRAME ====
                buildRow(
                  title: "Mã hợp đồng",
                  value: "SL-DA688",
                  isCopy: true,
                  scale: scale,
                ),
                buildRow(
                  title: "Bên bán",
                  value: "CÔNG TY CỔ PHẦN ĐẦU TƯ SLM",
                  scale: scale,
                ),
                buildRow(
                  title: "Bên mua",
                  value: "HOÀNG NGỌC TÂN",
                  scale: scale,
                ),
                buildRow(
                  title: "Ngày ký",
                  value: "19/03/2025",
                  scale: scale,
                  hasBorder: false, // dòng cuối không gạch
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ====== WIDGET DÒNG ======
  Widget buildRow({
    required String title,
    required String value,
    required double Function(double) scale,
    bool isCopy = false,
    bool hasBorder = true,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: scale(12)),
      decoration: BoxDecoration(
        border: hasBorder
            ? const Border(
                bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1),
              )
            : null,
      ),
      child: Row(
        children: [
          /// Cột trái
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w400,
                fontSize: scale(12),
                height: 18 / 12,
                color: const Color(0xFF848484),
              ),
            ),
          ),

          /// Cột phải
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: scale(14),
                      height: 20 / 14,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                ),

                /// Icon Copy nếu có
                if (isCopy)
                  Padding(
                    padding: EdgeInsets.only(left: scale(6)),
                    child: SvgPicture.asset(
                      'assets/icons/copy.svg',
                      width: scale(24),
                      height: scale(24),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailInfoCard extends StatelessWidget {
  const DetailInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: scale(402),
            padding: EdgeInsets.all(scale(16)),
            decoration: BoxDecoration(
              color: const Color(0x33F3F3F3), // #F3F3F333 glass
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE0E0E0), // xám nhạt đẹp
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== TITLE =====
                Text(
                  "Thông tin chi tiết",
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: scale(18),
                    height: 28 / 18,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),

                SizedBox(height: scale(12)),

                /// ===== CONTENT ROWS =====
                buildItem(
                  scale: scale,
                  title: "Tấm Quang Năng",
                  value: "PV JASolar | 580W | 1 mặt kính",
                  quantity: "10 tấm",
                  isLast: false,
                ),
                buildItem(
                  scale: scale,
                  title: "Biến tần",
                  value: "Solis Hybrid 5kW | 1 pha",
                  quantity: "01 bộ",
                ),
                buildItem(
                  scale: scale,
                  title: "Pin lưu trữ",
                  value: "Pin Lithium Dyness | 5kWh | Bản xếp tầng",
                  quantity: "02 cái",
                ),
                buildItem(
                  scale: scale,
                  title: "Phụ kiện, vật tư",
                  value: "Tủ điện NLMT SolarMax",
                  quantity: "01 bộ",
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// === ONE ROW ITEM ===
  Widget buildItem({
    required double Function(double) scale,
    required String title,
    required String value,
    required String quantity,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: scale(12)),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1),
              ),
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT (title + value)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Small title
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    fontSize: scale(12),
                    height: 18 / 12,
                    color: const Color(0xFF848484),
                  ),
                ),

                SizedBox(height: scale(4)),

                /// Bold value
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: scale(14),
                    height: 20 / 14,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT (Số lượng + value)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Số lượng",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    fontSize: scale(12),
                    height: 18 / 12,
                    color: const Color(0xFF848484),
                  ),
                ),

                SizedBox(height: scale(4)),

                Text(
                  quantity,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: scale(14),
                    height: 20 / 14,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
