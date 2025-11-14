import 'dart:ui';
import 'package:flutter/material.dart';
import '../../model/customer_model.dart';
import '../services/load_customer.dart';
import '../widgets/customer_item_card.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          /// ======================= NÚT BACK =======================
          Positioned(
            top: scale(74),
            left: scale(14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(256),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: scale(48),
                  height: scale(48),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(256),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color.fromARGB(221, 255, 0, 0),
                      size: 18,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),

          /// ======================= TIÊU ĐỀ =======================
          Positioned(
            top: scale(74),
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Danh sách khách hàng",
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  fontSize: scale(20),
                  height: 25 / 20,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
            ),
          ),

          /// ======================= 2 SMALL CARD =======================
          Positioned(
            top: scale(160),
            left: scale(16),
            right: scale(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallInfoCard(
                  scale,
                  title: "Tổng hoa hồng lũy kế",
                  value: "12.650.000",
                ),
                _buildSmallInfoCard(
                  scale,
                  title: "Tổng số đơn hàng",
                  value: "12",
                ),
              ],
            ),
          ),

          /// LISTVIEW KHÁCH HÀNG
          Positioned(
            top: scale(280),
            left: 0,
            right: 0,
            bottom: 0,
            child: FutureBuilder<List<CustomerModel>>(
              future: CustomerService.loadCustomers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Chưa có khách hàng"));
                }

                final customers = snapshot.data!;

                return ListView.separated(
                  padding: EdgeInsets.only(bottom: scale(30)),
                  itemCount: customers.length,
                  separatorBuilder: (_, __) => SizedBox(height: scale(12)),
                  itemBuilder: (context, i) {
                    final c = customers[i];
                    return CustomerItemCard(
                      name: c.name,
                      avatar: c.avatar,
                      giaTriHopDong: c.giaTriHopDong,
                      ngayBanGiao: c.ngayBanGiao,
                      hoaHong: c.hoaHong,
                      trangThai: c.trangThai,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ======================= SMALL CARD =======================
  Widget _buildSmallInfoCard(
    Function(double) scale, {
    required String title,
    required String value,
  }) {
    return Container(
      width: scale(191),
      height: scale(99),
      padding: EdgeInsets.all(scale(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: scale(14),
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(8)),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              fontSize: scale(22),
              color: const Color(0xFFEE4037),
            ),
          ),
        ],
      ),
    );
  }
}
