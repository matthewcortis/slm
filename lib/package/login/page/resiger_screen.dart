import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes.dart';

class LoginWithRegisterScreen extends StatefulWidget {
  const LoginWithRegisterScreen({super.key});

  @override
  State<LoginWithRegisterScreen> createState() =>
      _LoginWithRegisterScreenState();
}

class _LoginWithRegisterScreenState extends State<LoginWithRegisterScreen> {
  bool _obscure = true;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(); // Họ tên
  final _userController = TextEditingController(); // Tên đăng nhập (SĐT)
  final _passController = TextEditingController(); // Mật khẩu

  @override
  void dispose() {
    _nameController.dispose();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/bottom-nav');
    }
  }

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
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenH,
            child: Form(
              key: _formKey,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// Nút back góc trái trên cùng
                  Positioned(
                    top: 16 * scaleH,
                    left: 16 * scaleW,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.welcomeScreen,
                        );
                      },
                      child: Container(
                        width: 40 * scaleW,
                        height: 40 * scaleW,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1FD1D1D1),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Color(0xFF4F4F4F),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Hình illustration
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

                  Positioned(
                    top: (135 + 310 + 24) * scaleH,
                    left: 16 * scaleW,
                    child: SizedBox(
                      width: 398 * scaleW,
                      height: 58 * scaleH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
 
                        children: const [
                          Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 25 / 20,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          Text(
                            'Nhập thông tin để tạo tài khoản mới.',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 24 / 16,
                              color: Color(0xFF848484),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// --- Ô Họ tên ---
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
                            'Họ tên',
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
                                  child: TextFormField(
                                    controller: _nameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isCollapsed: true,
                                      hintText: 'Nhập họ tên',
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16 * scaleW,
                                        height: 24 / 16,
                                        color: const Color(0xFFBDBDBD),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16 * scaleW,
                                      height: 24 / 16,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Vui lòng nhập họ tên';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// --- Ô Tên đăng nhập ---
                  Positioned(
                    top: 600 * scaleH,
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
                                  child: TextFormField(
                                    controller: _userController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isCollapsed: true,
                                      hintText: 'Số điện thoại',
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16 * scaleW,
                                        height: 24 / 16,
                                        color: const Color(0xFFBDBDBD),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16 * scaleW,
                                      height: 24 / 16,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập tài khoản';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// --- Ô Mật khẩu ---
                  Positioned(
                    top: 690 * scaleH,
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
                              ],
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  width: 24 * scaleW,
                                  height: 24 * scaleH,
                                  color: const Color(0xFF4F4F4F),
                                ),
                                SizedBox(width: 8 * scaleW),
                                Expanded(
                                  child: TextFormField(
                                    controller: _passController,
                                    obscureText: _obscure,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isCollapsed: true,
                                      hintText: 'Mật khẩu của bạn',
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 24 / 16,
                                        color: Color(0xFFBDBDBD),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16 * scaleW,
                                      height: 24 / 16,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập mật khẩu';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
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

                  /// --- Vị trí hiển thị lỗi (giờ để trống cho đúng layout) ---
                  const Positioned(
                    top: 770, // nhân scaleH nếu cần chính xác
                    child: SizedBox.shrink(),
                  ),

                  /// --- Nút Đăng ký ---
                  Positioned(
                    top: 800 * scaleH,
                    left: 16 * scaleW,
                    child: SizedBox(
                      width: 398 * scaleW,
                      height: 48 * scaleH,
                      child: GestureDetector(
                        onTap: _handleRegister,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE4037),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26D1D1D1),
                                blurRadius: 34,
                                offset: Offset(0, 15),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
