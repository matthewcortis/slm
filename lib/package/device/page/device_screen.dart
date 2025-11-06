import 'package:flutter/material.dart';
import '../services/load_data.dart';
import '../../model/device_model.dart'; // chứa hàm loadCategoryById()
import '../widgets/device_widgets.dart';
import '../page/all_device_screen.dart'; // ⚡ chỉ thêm dòng này để hiển thị chi tiết
import '../model/product_device_model.dart';
class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  late Future<CategoryModel> futureCategory1;
  late Future<CategoryModel> futureCategory2;
  late Future<CategoryModel> futureCategory3;

  bool _showAllProducts = false;
  String _currentTitle = '';
  List<ProductDeviceModel> _currentProducts = [];

  @override
  void initState() {
    super.initState();
    futureCategory1 = loadCategoryById(1);
    futureCategory2 = loadCategoryById(2);
    futureCategory3 = loadCategoryById(3);
  }

  // 👉 Hàm mở chi tiết (thay Navigator.push)
  void _openAllProducts(String title, List<ProductDeviceModel> products) {
    setState(() {
      _showAllProducts = true;
      _currentTitle = title;
      _currentProducts = products;
    });
  }

  // 👉 Hàm quay lại danh mục
  void _goBack() {
    setState(() {
      _showAllProducts = false;
      _currentTitle = '';
      _currentProducts = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    // ✅ Nếu đang xem chi tiết
    if (_showAllProducts) {
      return AllProductDeviceScreen(
        title: _currentTitle,
        products: _currentProducts,
        onBack: _goBack,
      );
    }

    // ✅ Mặc định hiển thị danh sách thiết bị
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: scale(0), vertical: scale(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ---------------- Header ----------------
                Text(
                  'Danh sách thiết bị',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    fontSize: scale(20),
                    height: 25 / 20,
                    color: const Color(0xFF4F4F4F),
                  ),
                ),
                SizedBox(height: scale(24)),

                // --- Danh mục 1: Tấm quang năng ---
                FutureBuilder<CategoryModel>(
                  future: futureCategory1,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DeviceWidgetSection(
                      category: snapshot.data!,
                      onShowAll: _openAllProducts, // ✅ thêm callback
                    );
                  },
                ),
                SizedBox(height: scale(32)),

                // --- Danh mục 2: Biến tần ---
                FutureBuilder<CategoryModel>(
                  future: futureCategory2,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DeviceWidgetSection(
                      category: snapshot.data!,
                      onShowAll: _openAllProducts,
                    );
                  },
                ),
                SizedBox(height: scale(32)),

                // --- Danh mục 3: Pin Lithium ---
                FutureBuilder<CategoryModel>(
                  future: futureCategory3,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DeviceWidgetSection(
                      category: snapshot.data!,
                      onShowAll: _openAllProducts,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
