import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ProfileHeader(),
              SizedBox(height: 8,),
              // Bạn có thể thêm các section khác ở đây
              ProfileSettingsSection()
            ],
          ),
        ),
      ),
    );
  }
}
