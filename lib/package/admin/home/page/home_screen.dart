import 'package:flutter/material.dart';

import '../../../controllers/products/category_product.dart';
import '../../../controllers/products/load_data.dart';
import '../../../home/widgets/app_bar_home.dart';
import '../../../home/widgets/list_product.dart';
import '../../../home/widgets/bank_contract_info.dart';
import '../../../news/services/load_faq.dart';       // chứa loadFAQ()
import '../../../news/services/load_tutorial.dart'; // chứa loadTutorial()

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: FutureBuilder<ProductCategoryModel>(
        future: loadAllProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryData   = snapshot.data!;
          final hotProducts    = categoryData.hotProducts;
          final deviceProducts = categoryData.deviceProducts;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  const SolarHeaderFullCard(),
                  const SizedBox(height: 24),

                  const BankContractCard(),
                  const SizedBox(height: 24),

                  BestSellerSection(products: hotProducts),
                  const SizedBox(height: 24),

                  ProductDevice(
                    products_device: deviceProducts,
                    futureFAQ: loadFAQ(),
                    futureTutorial: loadTutorial(),
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
