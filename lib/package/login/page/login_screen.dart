import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true; // 👁 Ẩn/hiện mật khẩu

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;

    const figmaW = 430.0;
    const figmaH = 932.0;

    final scaleW = screenW / figmaW;
    final scaleH = screenH / figmaH;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                /// --- SVG minh hoạ ---
                Positioned(
                  top: 86 * scaleH,
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

                /// --- Khối chào mừng ---
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
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight:
                                FontWeight.w600, // tương đương 590 Figma
                            fontSize: 20,
                            height: 25 / 20, // line height = 25px
                            color: Color(0xFF4F4F4F), // Gray-G5
                          ),
                        ),

                        // --- Mô tả ---
                        Text(
                          'Bạn đã sẵn sàng! Đăng nhập để bắt đầu trải nghiệm.',
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 24 / 16, // line height = 24px
                            color: Color(0xFF848484), // Gray-G4
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// --- Ô nhập liệu: Tên đăng nhập ---
                Positioned(
                  top: 510 * scaleH,
                  left: 16 * scaleW,
                  child: SizedBox(
                    width: 398 * scaleW,
                    height: 76 * scaleH,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên đăng nhập',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                            fontSize: 16 * scaleW,
                            height: 20 / 16,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                        SizedBox(height: 8 * scaleH),

                        Container(
                          width: 398 * scaleW,
                          height: 48 * scaleH,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * scaleW,
                            vertical: 12 * scaleH,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26D1D1D1),
                                blurRadius: 34,
                                offset: Offset(0, 15),
                              ),
                              BoxShadow(
                                color: Color(0x21D1D1D1),
                                blurRadius: 61,
                                offset: Offset(0, 61),
                              ),
                              BoxShadow(
                                color: Color(0x14D1D1D1),
                                blurRadius: 82,
                                offset: Offset(0, 137),
                              ),
                              BoxShadow(
                                color: Color(0x0DD1D1D1),
                                blurRadius: 98,
                                offset: Offset(0, 244),
                              ),
                              BoxShadow(
                                color: Color(0x00D1D1D1),
                                blurRadius: 107,
                                offset: Offset(0, 382),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/user.svg',
                                width: 24 * scaleW,
                                height: 24 * scaleH,
                                color: const Color(0xFF4F4F4F),
                              ),
                              SizedBox(width: 8 * scaleW),
                              Expanded(
                                child: Text(
                                  'Số điện thoại',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16 * scaleW,
                                    height: 24 / 16,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// --- Ô nhập liệu: Mật khẩu ---
                Positioned(
                  top: 610 * scaleH,
                  left: 16 * scaleW,
                  child: SizedBox(
                    width: 398 * scaleW,
                    height: 76 * scaleH,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mật khẩu',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                            fontSize: 16 * scaleW,
                            height: 20 / 16,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                        SizedBox(height: 8 * scaleH),
                        Container(
                          width: 398 * scaleW,
                          height: 48 * scaleH,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * scaleW,
                            vertical: 12 * scaleH,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26D1D1D1),
                                blurRadius: 34,
                                offset: Offset(0, 15),
                              ),
                              BoxShadow(
                                color: Color(0x21D1D1D1),
                                blurRadius: 61,
                                offset: Offset(0, 61),
                              ),
                              BoxShadow(
                                color: Color(0x14D1D1D1),
                                blurRadius: 82,
                                offset: Offset(0, 137),
                              ),
                              BoxShadow(
                                color: Color(0x0DD1D1D1),
                                blurRadius: 98,
                                offset: Offset(0, 244),
                              ),
                              BoxShadow(
                                color: Color(0x00D1D1D1),
                                blurRadius: 107,
                                offset: Offset(0, 382),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Icon trái (khóa)
                              SvgPicture.asset(
                                'assets/icons/lock.svg',
                                width: 24 * scaleW,
                                height: 24 * scaleH,
                                color: const Color(0xFF4F4F4F),
                              ),
                              SizedBox(width: 8 * scaleW),

                              // TextField (ẩn/hiện)
                              Expanded(
                                child: TextField(
                                  obscureText: _obscure,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    hintText: 'Mật khẩu của bạn',
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16 * scaleW,
                                    height: 24 / 16,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),

                              // Icon con mắt phải
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscure = !_obscure;
                                  });
                                },
                                child: SvgPicture.asset(
                                  _obscure
                                      ? 'assets/icons/vision_off.svg'
                                      : 'assets/icons/vision.svg',
                                  width: 24 * scaleW,
                                  height: 24 * scaleH,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 710 * scaleH,
                  left: 16 * scaleW,
                  child: SizedBox(
                    width: 398 * scaleW,
                    height: 108 * scaleH,
                    child: Column(
                      children: [
                        Container(
                          width: 398 * scaleW,
                          height: 48 * scaleH,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26D1D1D1),
                                blurRadius: 34,
                                offset: Offset(0, 15),
                              ),
                              BoxShadow(
                                color: Color(0x21D1D1D1),
                                blurRadius: 61,
                                offset: Offset(0, 61),
                              ),
                              BoxShadow(
                                color: Color(0x14D1D1D1),
                                blurRadius: 82,
                                offset: Offset(0, 137),
                              ),
                              BoxShadow(
                                color: Color(0x0DD1D1D1),
                                blurRadius: 98,
                                offset: Offset(0, 244),
                              ),
                              BoxShadow(
                                color: Color(0x00D1D1D1),
                                blurRadius: 107,
                                offset: Offset(0, 382),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w600,
                                fontSize: 16 * scaleW,
                                height: 20 / 16,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12 * scaleH),
                        // 🔴 Nút Đăng nhập (Primary)
                        Container(
                          width: 398 * scaleW,
                          height: 48 * scaleH,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE4037),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26D1D1D1),
                                blurRadius: 34,
                                offset: Offset(0, 15),
                              ),
                              BoxShadow(
                                color: Color(0x21D1D1D1),
                                blurRadius: 61,
                                offset: Offset(0, 61),
                              ),
                              BoxShadow(
                                color: Color(0x14D1D1D1),
                                blurRadius: 82,
                                offset: Offset(0, 137),
                              ),
                              BoxShadow(
                                color: Color(0x0DD1D1D1),
                                blurRadius: 98,
                                offset: Offset(0, 244),
                              ),
                              BoxShadow(
                                color: Color(0x00D1D1D1),
                                blurRadius: 107,
                                offset: Offset(0, 382),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w600,
                                fontSize: 16 * scaleW,
                                height: 20 / 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // ⚪ Nút Đăng ký (Secondary)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
