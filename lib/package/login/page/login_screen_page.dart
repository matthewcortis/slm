import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../controllers/login/login_controller.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
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
          case "sale":
          case "agent":
          case "customer":
            Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
            break;

          case "guest":
          default:
            Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
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
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      SizedBox(height: figmaH * scaleH, width: screenW),

                      // Nút back góc trái trên cùng
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

                      Positioned(
                        top: (135 + 310 + 24) * scaleH,
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
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20 * scaleW,
                                  height: 25 / 20,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
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

                      Positioned(
                        top: (135 + 310 + 58 + 40) * scaleH,
                        left: 16 * scaleW,
                        child: SizedBox(
                          width: 398 * scaleW,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// --- Ô nhập Tên đăng nhập ---
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    Container(
                                      height: 48 * scaleH,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFFE0E0E0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/user.svg',
                                            width: 20,
                                            height: 20,
                                            color: const Color.fromARGB(
                                              255,
                                              3,
                                              3,
                                              3,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _userController,
                                              keyboardType: TextInputType.phone,
                                              style: const TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xFF333333),
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Số điện thoại',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'SF Pro',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Color(0xFFBDBDBD),
                                                ),
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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

                              const SizedBox(height: 16),

                              /// --- Ô nhập Mật khẩu ---
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Mật khẩu',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        height: 1.4,
                                        color: Color(0xFF4F4F4F),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
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
                                          SvgPicture.asset(
                                            'assets/icons/lock.svg',
                                            width: 20,
                                            height: 20,
                                            color: const Color.fromARGB(
                                              255,
                                              3,
                                              3,
                                              3,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _passController,
                                              obscureText: _obscure,
                                              style: const TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xFF333333),
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '**********',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFFBDBDBD),
                                                  fontFamily: 'SF Pro',
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Vui lòng nhập mật khẩu';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(
                                              () => _obscure = !_obscure,
                                            ),
                                            child: Icon(
                                              _obscure
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: const Color(0xFF848484),
                                            ),
                                          ),
                                        ],
                                      ),
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

                      Positioned(
                        top: (135 + 310 + 58 + 204 + 30) * scaleH,
                        left: 16 * scaleW,
                        right: 16 * scaleW,
                        child: Consumer<LoginController>(
                          builder: (context, controller, child) {
                            if (controller.errorMessage != null) {
                              return Text(
                                controller.errorMessage!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14 * scaleW,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),

                      // --- Nút Đăng nhập ---
                      Positioned(
                        top: (135 + 310 + 58 + 204 + 60) * scaleH,
                        left: 16 * scaleW,
                        child: SizedBox(
                          width: 398 * scaleW,
                          height: 48 * scaleH,
                          child: Consumer<LoginController>(
                            builder: (context, controller, child) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFED1C24),
                                  ),
                                );
                              }

                              return ElevatedButton(
                                onPressed: _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED1C24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                              );
                            },
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
