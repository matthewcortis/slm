import 'package:flutter/material.dart';
import '../../home/services/product_category_model.dart';
import '../services/load_product.dart';
import '../widgets/app_bar_home.dart';
import '../widgets/list_product.dart';
import '../../news/services/load_faq.dart';
import '../../news/services/load_tutorial.dart';
import '../../model/faq_model.dart';
import '../../model/tutorial_model.dart';
import '../widgets/warranty_price.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<ProductCategoryModel> _futureProducts;
  late final Future<List<FAQModel>> _futureFAQ;
  late final Future<List<TutorialModel>> _futureTutorial;

  @override
  void initState() {
    super.initState();
    _futureProducts = loadAllProducts();
    _futureFAQ = loadFAQ();
    _futureTutorial = loadTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: FutureBuilder<ProductCategoryModel>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryData = snapshot.data!;
          final hotProducts = categoryData.hotProducts;
          final deviceProducts = categoryData.deviceProducts;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  const SolarHeaderFullCard(),
                  const SizedBox(height: 24),
                  ContractValueCard(
                    deliveryDate: "12/03/2025",
                    totalValue: "12.650.000 đ",
                    onView: () {
                      Navigator.of(
                        context,
                        rootNavigator: false,
                      ).pushNamed('/warranty');
                    },
                  ),
                  const SizedBox(height: 24),

                  BestSellerSection(products: hotProducts),
                  const SizedBox(height: 24),

                  ProductDevice(
                    products_device: deviceProducts,
                    futureFAQ: _futureFAQ,
                    futureTutorial: _futureTutorial,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
