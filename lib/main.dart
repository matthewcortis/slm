import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './routes.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const SolarMaxApp(),
    ),
  );
}

class SolarMaxApp extends StatelessWidget {
  const SolarMaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932), // 👈 Kích thước khung Figma
      minTextAdapt: true,               
      splitScreenMode: true,            
      builder: (_, child) {
        return MaterialApp(
          title: 'Solar Max',
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true, // 👈 Kết hợp DevicePreview
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          routes: AppRoutes.getRoutes(),
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}
