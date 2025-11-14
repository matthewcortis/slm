import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/combo_card.dart';
import '../../product/page/product_list_screen.dart';

class ComboListScreen extends StatefulWidget {
  const ComboListScreen({super.key});

  @override
  State<ComboListScreen> createState() => _ComboListScreenState();
}
class _ComboListScreenState extends State<ComboListScreen> {
  List<dynamic> combos = [];
  Map<String, dynamic>? selectedCombo;

  Future<void> loadCombos() async {
    final jsonString = await rootBundle.loadString('assets/data/combos.json');
    final data = json.decode(jsonString);
    setState(() => combos = data['combos']);
  }

  @override
  void initState() {
    super.initState();
    loadCombos();
  }

  bool _hasProducts(Map<String, dynamic> combo) {
    final products = combo['products'];
    return products is List && products.isNotEmpty;
  }

  void _handleTap(Map<String, dynamic> combo) {
    if (_hasProducts(combo)) {
      setState(() => selectedCombo = combo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Combo này chưa có sản phẩm')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    if (selectedCombo != null) {
      return ProductListScreen(
        comboProducts: selectedCombo!['products'],
        comboName: selectedCombo!['text'],
        onBack: () => setState(() => selectedCombo = null),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scale(16), vertical: scale(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Danh sách Combo',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w600,
                  fontSize: scale(20),
                  height: 25 / 20,
                  color: const Color(0xFF4F4F4F),
                ),
              ),
              SizedBox(height: scale(24)),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 191 / 126,
                  ),
                  itemCount: combos.length,
                  itemBuilder: (context, index) {
                    final combo = (combos[index] as Map).cast<String, dynamic>();
                    return GestureDetector(
                      onTap: () => _handleTap(combo),
                      child: BrandCard(
                        iconPath: combo['icon'],
                        text: combo['text'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
