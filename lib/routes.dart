import 'package:flutter/material.dart';
import './package/login/page/splash_screen.dart';
import 'package/login/page/welcome_screen.dart';
import './package/login/page/login_screen.dart';
import './package/login/page/login_screen_page.dart';
import './package/bottom_nav.dart';
import './package/home/page/home_page_screen.dart';
import './package/news/pages/detail_news_screen.dart';
import './package/device/page/detail_product_device_screen.dart';
import './package/product/page/detail_product_screen.dart';
import './package/home/page/warranty_device_screenn.dart';

class AppRoutes {
  static final String splashScreen = '/splash-screen';
  static final String welcomeScreen = '/welcome-screen';
  static final String loginScreen = '/login-screen';
  static final String loginScreenPage = '/login-screen-page';
  static final String bottomNav = '/bottom-nav';
  static final String homeScreen = '/home';
  static final String detailNewsScreen = '/detail-news';
  static final String detailProductDevice = '/detail-product-device'; // device
  static final String detailProduct = '/detail-product';
  static final String warrantyDeviceScreen = "/warranty";
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      welcomeScreen: (context) => const WelcomeScreen(),
      loginScreen: (context) => const LoginScreen(),
      loginScreenPage: (context) => const LoginScreenPage(),
      bottomNav: (context) => const MainNavScreen(),
      homeScreen: (context) => const HomeScreen(),
      detailNewsScreen: (context) => const DetailNewsScreen(),
      detailProductDevice: (context) => const ProductDetailScreen(),
      detailProduct: (context) => const DetailProduct(),
      warrantyDeviceScreen: (context) => const WarrantyDeviceScreen(),
      // Thêm các route khác tại đây
    };
  }
}


// push() ➜ thêm 1 route mới lên stack

// pop() ➜ quay lại route trước đó

// pushReplacement() ➜ thay route hiện tại 

// pushNamed() ➜ điều hướng theo tên route (nếu đã định nghĩa trước)