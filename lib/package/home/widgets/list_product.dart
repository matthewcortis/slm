import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/ProductModel.dart';
import '../../model/product_device_model.dart';
import '../../product/widgets/product_card.dart';
import '../../product/widgets/product_card_temp.dart';
import '../../model/faq_model.dart';
import '../../model/tutorial_model.dart';
import '../../news/widgets/faq_item_card.dart';
import '../../news/widgets/news_item_card.dart';
//done
class BestSellerSection extends StatelessWidget {
  final List<ProductHotModel> products;
  const BestSellerSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(398),
      padding: EdgeInsets.symmetric(horizontal: scale(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header Row ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sản phẩm bán chạy',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w600, // Semibold ~590
                  fontSize: scale(18),
                  height: 28 / 18,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
              Text(
                'Xem chi tiết',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w600,
                  fontSize: scale(12),
                  height: 18 / 12,
                  color: const Color(0xFFEE4037),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFEE4037),
                  decorationThickness: 1,
                ),
              ),
            ],
          ),

          SizedBox(height: scale(12)),

          // --- Horizontal List ---
          SizedBox(
            width: 398.w,
            height: 400.h,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => SizedBox(width: scale(16)),
              itemBuilder: (context, index) {
                return ProductItemCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDevice extends StatefulWidget {
  final List<ProductDeviceModel> products_device;
  final Future<List<FAQModel>> futureFAQ;
  final Future<List<TutorialModel>> futureTutorial;

  const ProductDevice({
    super.key,
    required this.products_device,
    required this.futureFAQ,
    required this.futureTutorial,
  });

  @override
  State<ProductDevice> createState() => _ProductDeviceState();
}

class _ProductDeviceState extends State<ProductDevice> {
  int selectedIndex = 0;
  final List<String> tabs = ["Mega Story", "Hỏi đáp", "Hướng dẫn"];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Container(
      width: scale(398),
      padding: EdgeInsets.symmetric(horizontal: scale(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- HEADER ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Tin tức mới nhất',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 1.55,
                  color: Color(0xFF4F4F4F),
                ),
              ),
              Text(
                'Xem chi tiết',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFFEE4037),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFEE4037), 
                  decorationThickness: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ---------------- SEGMENT CONTROL ----------------
          Container(
            width: scale(406),
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E6), // Gray-G2 nền ngoài
              borderRadius: BorderRadius.circular(256),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tabs.length, (index) {
                final bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: scale(122),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(256),
                      color: isSelected
                          ? const Color(0xFF17D066)
                          : Colors.transparent,
                      boxShadow: isSelected
                          ? const [
                              BoxShadow(
                                color: Color(0x3317D066),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontWeight: isSelected
                              ? FontWeight.w500
                              : FontWeight.w400,
                          fontSize: 16,
                          height: 1.5,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF848484),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          // ---------------- TAB BODY ----------------
          SizedBox(
            width: scale(398),
            height: scale(439),
            child: IndexedStack(
              index: selectedIndex,
              children: [
                ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.products_device.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return ProductDeviceCard(
                      product: widget.products_device[index],
                    );
                  },
                ),

                FutureBuilder<List<FAQModel>>(
                  future: widget.futureFAQ,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Lỗi tải FAQ: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final faqList = snapshot.data ?? [];
                    if (faqList.isEmpty) {
                      return const Center(
                        child: Text('Không có câu hỏi nào hiện tại'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      clipBehavior: Clip.hardEdge,
                      itemCount: faqList.length,
                      itemBuilder: (context, index) {
                        final faq = faqList[index];
                        return FAQItem(title: faq.title, content: faq.content);
                      },
                    );
                  },
                ),

                FutureBuilder<List<TutorialModel>>(
                  future: widget.futureTutorial,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Lỗi tải tin: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final tutorialList = snapshot.data ?? [];
                    if (tutorialList.isEmpty) {
                      return const Center(
                        child: Text('Không có tin tức nào hiện tại'),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      primary: false,
                      clipBehavior: Clip.hardEdge,
                      itemCount: tutorialList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 17),
                      itemBuilder: (context, index) {
                        return NewsCardCard(news: tutorialList[index]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
