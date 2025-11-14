import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart'; // 👈 1. Import
import '../../controllers/login/login_controller.dart'; // 👈 2. Import Controller của bạn

class LoginWithRegisterScreen extends StatefulWidget {
  const LoginWithRegisterScreen({super.key});

  @override
  State<LoginWithRegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginWithRegisterScreen> {
  bool _obscure = true; 

  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Ẩn bàn phím nếu đang mở
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final controller = Provider.of<LoginController>(context, listen: false);

      final role = await controller.login(
        context,
        _userController.text,
        _passController.text,
      );

      if (!context.mounted) return;

      if (role != null) {
        switch (role) {
          case "admin":
          case "staff":
            Navigator.pushReplacementNamed(context, '/admin-home');
            break;
          case "customer":
            Navigator.pushReplacementNamed(context, '/home');
            break;
        }
      }
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
        child: LayoutBuilder(
          builder: (context, constraints) {
      
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                  
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
                      Positioned(
                        top: (135 + 310 + 24) *
                            scaleH, 
                        left: 16 * scaleW,
                        child: SizedBox(
                          width: 398 * scaleW,
                          height: 58 * scaleH,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Đăng nhập',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontWeight:
                                      FontWeight.w600,
                                  fontSize: 20,
                                  height: 25 / 20,
                                  color: Color(0xFF4F4F4F), 
                                ),
                              ),

                              // --- Mô tả ---
                              Text(
                                'Bạn đã sẵn sàng! Đăng nhập để bắt đầu trải nghiệm.',
                                style: const TextStyle(
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

                      Positioned(
                        top: 690 * scaleH,
                        child: Consumer<LoginController>(
                          builder: (context, controller, child) {
                            if (controller.errorMessage != null) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  controller.errorMessage!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return const SizedBox
                                .shrink();
                          },
                        ),
                      ),

                      /// --- Khối Nút Bấm ---
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
                                    // ...
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

                              Consumer<LoginController>(
                                builder: (context, controller, child) {
                                  if (controller.isLoading) {
                                    return SizedBox(
                                      width: 398 * scaleW,
                                      height: 48 * scaleH,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return GestureDetector(
                                    onTap: _handleLogin,
                                    child: Container(
                                      width: 398 * scaleW,
                                      height: 48 * scaleH,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEE4037),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x26D1D1D1),
                                            blurRadius: 34,
                                            offset: Offset(0, 15),
                                          ),
                                          // ...
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}