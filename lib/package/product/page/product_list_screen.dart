import 'package:flutter/material.dart';
import '../../model/ProductModel.dart';
import '../services/load_product.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final List<dynamic>? comboProducts;
  final String? comboName;
  final VoidCallback? onBack;
  const ProductListScreen({
    super.key,
    this.comboProducts,
    this.comboName,
    this.onBack,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isHybridSelected = true;
  List<ProductHotModel> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (widget.comboProducts != null) {
      // ✅ Dữ liệu lấy từ combo truyền sang
      setState(() {
        products = widget.comboProducts!
            .map((e) => ProductHotModel.fromJson(e))
            .toList();
      });
    } else {
      // ✅ Nếu không có comboProducts thì load toàn bộ sản phẩm từ file
      final data = await loadProducts();
      setState(() => products = data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) {
      return isHybridSelected ? p.type == 'Hy-Brid' : p.type == 'On-grid';
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          // --- Header ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onBack ?? () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                Text(
                  widget.comboName ?? 'Danh sách sản phẩm',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),

          // --- Tabs ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  _buildTabButton('Hy-Brid', true),
                  _buildTabButton('On-grid', false),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- Product List ---
          Expanded(
            child: products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 cột
                          mainAxisSpacing: 16, // khoảng cách dọc
                          crossAxisSpacing: 16, // khoảng cách ngang
                          childAspectRatio: 202 / 355, // đúng tỉ lệ card
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductItemCard(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isHybrid) {
    final selected = isHybrid ? isHybridSelected : !isHybridSelected;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isHybridSelected = isHybrid),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF00D26A) : Colors.transparent,
            borderRadius: BorderRadius.circular(23),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
