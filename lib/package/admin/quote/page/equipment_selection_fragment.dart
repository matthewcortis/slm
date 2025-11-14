import 'package:flutter/material.dart';
import '../widgets/equipment/equipment_selection.dart';
import '../widgets/equipment/equipment_list.dart';

class DanhMucScreen extends StatelessWidget {
  const DanhMucScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F8F8),
  
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DanhMucThietBiVaVatTu(), // phần khung lựa chọn danh mục
          
            AccessoriesListScreen(), // danh sách sản phẩm
          ],
        ),
      ),
    );
  }
}
