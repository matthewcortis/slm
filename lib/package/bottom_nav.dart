import 'package:flutter/material.dart';
import '../package/home/widgets/custom_bottom_nav.dart';
import './home/page/home_page_screen.dart';
import './combo/page/combo_screen.dart';
import './profile/page/profile_screen.dart';
import './news/pages/news_screen.dart';
import '../package/device/page/device_screen.dart';
import '../package/news/pages/detail_news_screen.dart';
import '../package/device/page/detail_product_device_screen.dart';
import '../package/product/page/detail_product_screen.dart';
import '../package/home/page/warranty_device_screenn.dart';
class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0; // Mặc định

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Combo
    GlobalKey<NavigatorState>(), // Device
    GlobalKey<NavigatorState>(), // News
    GlobalKey<NavigatorState>(), // Profile
  ];

  void _onTap(int index) {
    if (index == _currentIndex) {
      // Nếu nhấn lại tab hiện tại → quay về route đầu
      _navigatorKeys[index].currentState!.popUntil((r) => r.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInTab = !await _navigatorKeys[_currentIndex]
            .currentState!
            .maybePop();
        if (isFirstRouteInTab && _currentIndex != 0) {
          setState(() => _currentIndex = 0);
          return false;
        }
        return isFirstRouteInTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildNavigator(_navigatorKeys[0], const HomeScreen()),
            _buildNavigator(_navigatorKeys[1], const ComboListScreen()),
            _buildNavigator(_navigatorKeys[2], const DeviceListScreen()),
            _buildNavigator(_navigatorKeys[3], const NewsScreen()), 
            _buildNavigator(_navigatorKeys[4], const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }

  Widget _buildNavigator(GlobalKey<NavigatorState> key, Widget child) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) {
  
        if (settings.name == '/detail-product-device') {
          //final product = settings.arguments as ProductDeviceModel;
          return MaterialPageRoute(builder: (_) => ProductDetailScreen());
        }
        if (settings.name == '/detail-product') {
          //final product = settings.arguments as ProductDeviceModel;
          return MaterialPageRoute(builder: (_) => DetailProduct());
        }
         if (settings.name == '/warranty') {
          //final product = settings.arguments as ProductDeviceModel;
          return MaterialPageRoute(builder: (_) => WarrantyDeviceScreen());
        }
        if (settings.name == '/detail-news') {
          return MaterialPageRoute(builder: (_) => const DetailNewsScreen());
        }
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }
}
