import 'package:flutter/material.dart';
import '../widgets/equipment/equipment_selection.dart';
import '../widgets/equipment/equipment_list.dart';

class DanhMucScreen extends StatelessWidget {
  final String? selectedType;
  final String? selectedPhase;

  const DanhMucScreen({super.key, this.selectedType, this.selectedPhase});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F8F8),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            DanhMucThietBiVaVatTu(
              selectedType: selectedType,
              selectedPhase: selectedPhase,
            ), // phần khung lựa chọn danh mục

            AccessoriesListScreen(), // danh sách sản phẩm
          ],
        ),
      ),
    );
  }
}
