import 'package:flutter/material.dart';
import '../widgets/header_news_detail.dart';
import '../widgets/detail_content_news.dart';
import '../widgets/detail_relate_news.dart';
import '../../model/product_device_model.dart';
import '../services/load_products.dart'; // nơi chứa hàm loadProducts()

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({super.key});

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  late Future<List<ProductDeviceModel>> productNews;

  @override
  void initState() {
    super.initState();
    productNews = loadProducts(); // ✅ Gọi hàm load dữ liệu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            SolarArticleHeader(
              imageAsset: 'assets/images/banner-detail.jpg',
              title:
                  'Điện mặt trời SoLarMax | Em biết không? | Phần 4 | DA296 - Hải Dương...',
              authorName: 'Khuất Duy Quang',
              authorRole: 'Đại lý A',
              avatarAsset: 'assets/images/avatar.jpg',
              onBack: () => Navigator.pop(context),
              onAction: () {
                // xử lý PDF
              },
            ),

            const SizedBox(height: 12),

            // ===== Tóm tắt =====
            Center(
              child: NewsSummaryCard(
                views: 3800,
                datePosted: '12/06/2024',
                dateUpdated: '12/06/2024',
                title: 'Tóm tắt',
                content:
                    'Dyness, một công ty tiên phong trong lĩnh vực lưu trữ năng lượng, đã khẳng định vị thế dẫn đầu nhờ vào kho tàng sở hữu trí tuệ phong phú. '
                    'Với hơn 120 quyền sở hữu trí tuệ độc lập, bao gồm các công nghệ cốt lõi như pin lithium iron phosphate (LiFePO4), hệ thống quản lý pin (BMS), '
                    'hệ thống quản lý năng lượng (EMS) và tích hợp hệ thống lưu trữ năng lượng, Dyness không chỉ đảm bảo hiệu suất cao mà còn thúc đẩy sự phát triển '
                    'bền vững trong lĩnh vực năng lượng sạch.',
              ),
            ),

            const SizedBox(height: 12),

            // ===== Video khách hàng =====
            Center(
              child: CustomerFeedbackCard(
                title: 'Khách hàng nói gì, nghĩ gì?',
                content:
                    'Gia đình anh Phúc mỗi tháng hoá đơn tiền điện dao động 4 triệu đồng, tương đương 1200 kWh/tháng, hoặc 40 kWh/ngày. '
                    'Vào những ngày hè, gia đình thường xuyên sử dụng 2 điều hoà Daikin 9000 BTU, công suất 700 W từ 10–15 tiếng mỗi ngày. '
                    'Mỗi giờ, mỗi điều hoà tiêu thụ 0.7 kWh tiền điện, tương đương 15–20 kWh/ngày chỉ cho điều hoà.',
                mediaAsset: 'assets/videos/1409899-uhd_3840_2160_25fps.mp4',
                caption:
                    'Sunjin Dong Nai Project – Capacity 1.543 MWp – Installation in Dong Nai Province',
                isVideo: true,
              ),
            ),

            const SizedBox(height: 10),

            // ===== Ảnh minh họa =====
            Center(
              child: CustomerFeedbackCard(
                title: 'Giải pháp của Solarmax?',
                content:
                    'Gia đình anh Phúc mỗi tháng hoá đơn tiền điện dao động 4 triệu đồng, tương đương 1200 kWh/tháng, hoặc 40 kWh/ngày. '
                    'Vào những ngày hè, gia đình thường xuyên sử dụng 2 điều hoà Daikin 9000 BTU, công suất 700 W từ 10–15 tiếng mỗi ngày. '
                    'Mỗi giờ, mỗi điều hoà tiêu thụ 0.7 kWh tiền điện, tương đương 15–20 kWh/ngày chỉ cho điều hoà.',
                mediaAsset: 'assets/images/banner-detail.jpg',
                caption:
                    'Sunjin Dong Nai Project – Capacity 1.543 MWp – Installation in Dong Nai Province',
              ),
            ),

            const SizedBox(height: 10),

            // ===== Tin tức liên quan =====
            FutureBuilder<List<ProductDeviceModel>>(
              future: productNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Lỗi khi tải dữ liệu'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm liên quan'));
                } else {
                  return Center(
                    child: RelatedNewsSection(productsDevice: snapshot.data!),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
