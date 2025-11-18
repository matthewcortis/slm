import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../../controllers/login/auth_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: AuthStorage.getRole(),
          builder: (context, snapshot) {
            final role = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                children: [

                  if (role != null) ...[
                    const ProfileHeader(
                      avatarUrl: 'assets/images/avatar.jpg',
                      fullName: 'Nguyễn Văn A',
                      role: 'Khách hàng',
                    ),
                    const SizedBox(height: 8),
                    const ProfileSettingsTopSection(),
                  ],

  
                  const ProfileSettingsSection(),

                  if (role != null) ...[const ProfileLogoutSection()],

                  if (role == null) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Bạn đang ở chế độ khách vãng lai',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Đăng nhập để xem đầy đủ thông tin hồ sơ.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
