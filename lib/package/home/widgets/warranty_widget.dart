import 'package:flutter/material.dart';
import '../../model/warranty_model.dart';
import '../services/load_warranty.dart';
import 'warranty_item_card.dart';
class WarrantyWidget extends StatefulWidget {
  const WarrantyWidget({super.key});

  @override
  State<WarrantyWidget> createState() => _WarrantyWidgetState();
}

class _WarrantyWidgetState extends State<WarrantyWidget> {
  late Future<List<WarrantyItemModel>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = loadWarrantyItems();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scale(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          /// DA688
          Text(
            "DA688",
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: scale(20),
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(12)),

          /// Title
          Text(
            "Sản phẩm bảo hành",
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: scale(18),
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(12)),
          /// DATA LIST
          FutureBuilder<List<WarrantyItemModel>>(
            future: futureItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text("Lỗi tải dữ liệu");
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("Không có sản phẩm bảo hành");
              }

              final items = snapshot.data!;
              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(), 
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: scale(12)),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return WarrantyItemCard(
                    image: item.image,
                    statusText: item.statusText,
                    productName: item.productName,
                    activeDate: item.activeDate,
                    duration: item.duration,
                    endDate: item.endDate,
                    progress: item.progress,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
