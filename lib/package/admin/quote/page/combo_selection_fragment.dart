// combo_selection_fragment.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/equipment/card_item_product_hy_on.dart';
import '../../../model/ProductModel.dart';
import '../../../product/services/load_product.dart';

typedef OnComboSelectionChanged =
    void Function(bool hasSelection, Map<String, dynamic>? combo);

class ComboSelectionFragment extends StatefulWidget {
  const ComboSelectionFragment({super.key, required this.onSelectionChanged});

  final OnComboSelectionChanged
  onSelectionChanged; // true nếu có item được chọn

  @override
  State<ComboSelectionFragment> createState() => _ComboSelectionFragmentState();
}

class _ComboSelectionFragmentState extends State<ComboSelectionFragment> {
  List<dynamic> combos = [];
  Map<String, dynamic>? selectedCombo;

  Future<void> loadCombos() async {
    final jsonString = await rootBundle.loadString('assets/data/combos.json');
    final data = json.decode(jsonString);
    setState(() => combos = data['combos']);
    // lúc mới vào chưa chọn gì
    widget.onSelectionChanged(false, null);
  }

  @override
  void initState() {
    super.initState();
    loadCombos();
  }

  void _toggleSelect(Map<String, dynamic> combo) {
    setState(() {
      if (selectedCombo?['id'] == combo['id']) {
        selectedCombo = null; // đang chọn -> về mặc định
      } else {
        selectedCombo = combo; // chọn item mới
      }
    });
    widget.onSelectionChanged(selectedCombo != null, selectedCombo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            width: 402,
            height: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lựa chọn loại Combo',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 28 / 18,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Chọn 1 loại combo để tiếp tục',
                  style: TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    color: Color(0xFF848484),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 191 / 110,
            ),
            itemCount: combos.length,
            itemBuilder: (context, index) {
              final combo = combos[index] as Map<String, dynamic>;
              final isSelected = selectedCombo?['id'] == combo['id'];
              return GestureDetector(
                onTap: () => _toggleSelect(combo),
                child: SelectableBrandCard(
                  label: combo['text'] ?? '',
                  iconPath: (combo['icon'] as String?)?.trim(),
                  selected: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Card như bạn đã có
class SelectableBrandCard extends StatelessWidget {
  const SelectableBrandCard({
    super.key,
    required this.label,
    this.iconPath,
    this.selected = false,
  });

  final String label;
  final String? iconPath;
  final bool selected;

  static const Color gray100 = Color(0xFFE6E6E6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green100 = Color(0xFFDBEBDD);
  static const Color green500 = Color(0xFF4D9A56);
  static const Color grayG5 = Color(0xFF4F4F4F);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 191,
      height: 110,
      padding: const EdgeInsets.all(16), // => content width 191-32 = 159
      decoration: BoxDecoration(
        color: selected ? gray100 : white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? green100 : gray100, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26D1D1D1),
            offset: Offset(0, 15),
            blurRadius: 34,
          ),
          BoxShadow(
            color: Color(0x21D1D1D1),
            offset: Offset(0, 61),
            blurRadius: 61,
          ),
          BoxShadow(
            color: Color(0x14D1D1D1),
            offset: Offset(0, 137),
            blurRadius: 82,
          ),
          BoxShadow(
            color: Color(0x0DD1D1D1),
            offset: Offset(0, 244),
            blurRadius: 98,
          ),
          BoxShadow(
            color: Color(0x00D1D1D1),
            offset: Offset(0, 382),
            blurRadius: 107,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // frame 159×24, space-between
          SizedBox(
            width: 159,
            height: 24,
            child: _IconRadioRow.explicit(
              selected: selected,
              iconPath: iconPath,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600, // ~590 Semibold
              fontSize: 12,
              height: 20 / 14,
              letterSpacing: 0,
              color: grayG5,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconRadioRow extends StatelessWidget {
  const _IconRadioRow({Key? key})
    : _selected = null,
      _iconPath = null,
      super(key: key);

  const _IconRadioRow.explicit({
    Key? key,
    required bool selected,
    String? iconPath,
  }) : _selected = selected,
       _iconPath = iconPath,
       super(key: key);

  final bool? _selected;
  final String? _iconPath;

  @override
  Widget build(BuildContext context) {
    bool selected =
        _selected ??
        context.findAncestorWidgetOfExactType<SelectableBrandCard>()!.selected;
    String? iconPath =
        _iconPath ??
        context.findAncestorWidgetOfExactType<SelectableBrandCard>()!.iconPath;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (iconPath != null && iconPath.isNotEmpty)
          SvgPicture.asset(iconPath, width: 20, height: 20)
        else
          const Icon(Icons.settings_outlined, size: 20, color: Colors.black),

        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromARGB(255, 242, 250, 243)
                : const Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: selected
              ? Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: SelectableBrandCard.green500,
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final List<dynamic>? comboProducts;
  final String? comboName;
  final VoidCallback? onBack;
  final bool? initialIsHybrid;
  final void Function(String type, bool hasAny)? onTypeSelected;
  final void Function(ProductHotModel? product)? onProductSelected;

  const ProductListScreen({
    super.key,
    this.comboProducts,
    this.comboName,
    this.onBack,
    this.onTypeSelected,
    this.initialIsHybrid,
    this.onProductSelected,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late bool isHybridSelected; // <-- dùng late
  int? selectedIndex;
  List<ProductHotModel> products = [];

  @override
  void initState() {
    super.initState();
    isHybridSelected = widget.initialIsHybrid ?? true;

    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (widget.comboProducts != null) {
      setState(() {
        products = widget.comboProducts!
            .map((e) => ProductHotModel.fromJson(e))
            .toList();
      });
    } else {
      final data = await loadProducts();
      setState(() => products = data);
    }
    _notifyType();
    widget.onProductSelected?.call(null);
  }

  void _notifyType() {
    final type = isHybridSelected ? 'Hy-Brid' : 'On-grid';
    final hasAny = products.any((p) => p.type == type);
    widget.onTypeSelected?.call(type, hasAny);
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) {
      return isHybridSelected ? p.type == 'Hy-Brid' : p.type == 'On-grid';
    }).toList();

    return SafeArea(
      child: Column(
        children: [
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
            child: filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 191 / 290,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final bool isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = null; // bỏ chọn
                            } else {
                              selectedIndex = index; // chọn mới
                            }
                          });
                          // báo cho màn cha biết hiện có chọn product hay không
                          ProductHotModel? selectedProduct;
                          if (selectedIndex != null) {
                            selectedProduct = filteredProducts[selectedIndex!];
                          }

                          widget.onProductSelected?.call(selectedProduct);
                        },
                        child: ProductItemCard(
                          product: product,
                          isSelected: isSelected,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // doi tab
  Widget _buildTabButton(String title, bool isHybrid) {
    final selected = isHybrid ? isHybridSelected : !isHybridSelected;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isHybridSelected != isHybrid) {
            setState(() {
              isHybridSelected = isHybrid;
              selectedIndex = null; // <-- đổi loại thì bỏ chọn product cũ
            });
            _notifyType();
             widget.onProductSelected?.call(null); 
          }
        },
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
