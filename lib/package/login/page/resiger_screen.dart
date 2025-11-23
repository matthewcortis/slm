import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes.dart';
import '../../api/api_service.dart'; // THÊM DÒNG NÀY
import '../../utils/location_region_service.dart';
class LoginWithRegisterScreen extends StatefulWidget {
  const LoginWithRegisterScreen({super.key});

  @override
  State<LoginWithRegisterScreen> createState() =>
      _LoginWithRegisterScreenState();
}

class _LoginWithRegisterScreenState extends State<LoginWithRegisterScreen> {
  bool _obscure = true;
  bool _isLoading = false; // trạng thái loading

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
Future<void> _handleRegister() async {
  FocusScope.of(context).unfocus();

  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _isLoading = true;
  });

  try {
    // >>> LẤY MÃ CƠ SỞ TỰ ĐỘNG
    String region = await LocationRegionService.getUserRegionVN();
    if (region == "Không xác định") {
      region = "HN";
    }

    final body = {
      "sdt": _userController.text.trim(),
      "matKhau": _passController.text.trim(),
      "hoVaTen": _nameController.text.trim(),
      "maCoSo": region,
    };

    final res =
        await ApiService.post("/basic-api/nguoi-dung/register", body);

    if (res is Map &&
        (res['status'] == 200 || res['success'] == true)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công')),
        );
        Navigator.pushReplacementNamed(context, '/bottom-nav');
      }
    } else {
      final msg = (res is Map && res['message'] != null)
          ? res['message'].toString()
          : 'Đăng ký không thành công.';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi kết nối: $e')),
      );
    }
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
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
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenH),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scaleW),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16 * scaleH),

                    /// Nút back góc trái trên cùng
                    GestureDetector(
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

                    SizedBox(height: 30 * scaleH),

                    // Hình illustration
                    SizedBox(
                      width: 398 * scaleW,
                      height: 310 * scaleH,
                      child: SvgPicture.asset(
                        'assets/icons/login.svg',
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 24 * scaleH),

                    // Tiêu đề
                    SizedBox(
                      width: 398 * scaleW,
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
                          SizedBox(height: 4),
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

                    SizedBox(height: 24 * scaleH),

                    /// --- Ô Họ tên ---
                    SizedBox(
                      width: 398 * scaleW,
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

                    SizedBox(height: 16 * scaleH),

                    /// --- Ô Tên đăng nhập ---
                    SizedBox(
                      width: 398 * scaleW,
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
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Vui lòng nhập tài khoản';
                                      }
                                      if (value.trim().length < 9) {
                                        return 'Số điện thoại không hợp lệ';
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

                    SizedBox(height: 16 * scaleH),

                    /// --- Ô Mật khẩu ---
                    SizedBox(
                      width: 398 * scaleW,
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
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Vui lòng nhập mật khẩu';
                                      }
                                      if (value.trim().length < 3) {
                                        return 'Mật khẩu tối thiểu 3 ký tự';
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

                    SizedBox(height: 32 * scaleH),

                    /// --- Nút Đăng ký ---
                    SizedBox(
                      width: 398 * scaleW,
                      height: 48 * scaleH,
                      child: GestureDetector(
                        onTap: _isLoading ? null : _handleRegister,
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
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : Text(
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

                    SizedBox(height: 24 * scaleH),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
