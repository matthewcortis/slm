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
  Map<String, dynamic>? selectedCombo; // ✅ combo được chọn

  Future<void> loadCombos() async {
    final jsonString = await rootBundle.loadString('assets/data/combos.json');
    final data = json.decode(jsonString);
    setState(() {
      combos = data['combos'];
    });
  }

  @override
  void initState() {
    super.initState();
    loadCombos();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    // ✅ Nếu có combo được chọn → hiển thị ProductListScreen trong cùng tab
    if (selectedCombo != null) {
      return ProductListScreen(
        comboProducts: selectedCombo!['products'],
        comboName: selectedCombo!['text'],
        onBack: () => setState(() => selectedCombo = null),
      );
    }

    // ✅ Mặc định hiển thị danh sách combo
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scale(16),
            vertical: scale(24),
          ),
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
                    childAspectRatio: 191 / 120,
                  ),
                  itemCount: combos.length,
                  itemBuilder: (context, index) {
                    final combo = combos[index];
                    return GestureDetector(
                      onTap: () {
                        // ✅ Không dùng Navigator.push nữa
                        if (combo['id'] == 1 && combo['products'] != null) {
                          setState(() {
                            selectedCombo = combo; // hiển thị danh sách sản phẩm
                          });
                        }
                      },
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
