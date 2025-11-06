import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes.dart';

class LoginScreenPage extends StatelessWidget {
  const LoginScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kích thước màn hình thực tế
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;

    // Kích thước Figma chuẩn
    const figmaW = 430.0;
    const figmaH = 932.0;

    // Tỷ lệ scale theo từng chiều
    final scaleW = screenW / figmaW;
    final scaleH = screenH / figmaH;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // #F8F8F8
      body: SafeArea(
        child: Stack(
          children: [
            // --- Hình minh hoạ SVG ---
            Positioned(
              top: 105 * scaleH,
              left: 16 * scaleW,
              child: SizedBox(
                width: 398 * scaleW,
                height: 310 * scaleH,
                child: SvgPicture.asset(
                  'assets/icons/login.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Đặt phần này ngay dưới SVG trong Stack, hoặc trong Column nếu bạn muốn
            Positioned(
              top:
                  (135 + 310 + 24) *
                  scaleH, // nằm dưới hình minh hoạ (310 cao) + khoảng cách nhỏ
              left: 16 * scaleW,
              child: SizedBox(
                width: 398 * scaleW,
                height: 58 * scaleH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --- Tiêu đề ---
                    Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                        fontSize: 20 * scaleW,
                        height: 25 / 20,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),

                    // --- Mô tả ---
                    Text(
                      'Bạn đã sẵn sàng! Đăng nhập để bắt đầu trải nghiệm.',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        fontSize: 16 * scaleW,
                        height: 24 / 16,
                        color: const Color(0xFF848484),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- Frame nhập thông tin ---
            Positioned(
              top:
                  (135 + 310 + 58 + 40) *
                  scaleH, // nằm dưới phần mô tả 1 khoảng nhỏ
              left: 16 * scaleW,
              child: SizedBox(
                width: 398 * scaleW,
                height: 208 * scaleH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// --- Ô nhập Tên đăng nhập ---
                    SizedBox(
                      height: 79 * scaleH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label
                          const Text(
                            'Tên đăng nhập',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.4,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Input field
                          Container(
                            height: 48 * scaleH,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text(
                              '0123456789',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Ô nhập Mật khẩu ---
                    SizedBox(
                      height: 79 * scaleH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lable', // bạn có thể đổi thành "Mật khẩu"
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.4,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // TextField có icon con mắt
                          StatefulBuilder(
                            builder: (context, setState) {
                              bool obscure = true;
                              return Container(
                                height: 48 * scaleH,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF848484),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        obscureText: obscure,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '**********',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF848484),
                                            fontFamily: 'SF Pro',
                                          ),
                                        ),
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () =>
                                    //       setState(() => obscure = !obscure),
                                    //   child: Icon(
                                    //     obscure
                                    //         ? Icons.visibility_off_outlined
                                    //         : Icons.visibility_outlined,
                                    //     color: const Color(0xFF848484),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// --- Quên mật khẩu ---
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Quên mật khẩu?',
                        style: const TextStyle(
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF848484),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- Nút Đăng nhập ---
            Positioned(
              top:
                  (135 + 310 + 58 + 204 + 60) *
                  scaleH, // dưới form 1 khoảng nhỏ
              left: 16 * scaleW,
              child: SizedBox(
                width: 398 * scaleW,
                height: 48 * scaleH,
                child: ElevatedButton(
                  onPressed: () {
                    // 🧭 Chuyển sang trang Home (bottomNav) với hiệu ứng Smart animate
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 350),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              final offsetAnimation =
                                  Tween<Offset>(
                                    begin: const Offset(0.2, 0.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                    ),
                                  );
                              return SlideTransition(
                                position: offsetAnimation,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          // ✅ Lấy widget thật từ routes map
                          final builder =
                              AppRoutes.getRoutes()[AppRoutes.bottomNav];
                          return builder != null
                              ? builder(context)
                              : const SizedBox.shrink(); // fallback nếu null
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFED1C24,
                    ), // màu thương hiệu đỏ (#ED1C24)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // border-radius: 12px
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // TODO: các phần khác (text, form, button) sẽ thêm sau theo yêu cầu
          ],
        ),
      ),
    );
  }
}
