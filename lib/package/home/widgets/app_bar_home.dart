import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/login/auth_storage.dart';
import 'package:solarmaxapp/routes.dart';

class SolarHeaderFullCard extends StatelessWidget {
  const SolarHeaderFullCard({super.key});

  static const double _baseWidth = 430.0;

  double _scale(BuildContext context, double value) {
    final screenWidth = MediaQuery.of(context).size.width;
    return value * screenWidth / _baseWidth;
  }

  Widget _buildActionByRole(
    BuildContext context,
    String? role,
    double Function(double) scale,
  ) {
    if (role == 'admin') {
      return GestureDetector(
        onTap: () {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AppRoutes.quoteScreen);
        },
        child: Container(
          width: scale(36),
          height: scale(36),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/baogia.svg',
              width: scale(16),
              height: scale(16),
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    return Container(
      width: scale(36),
      height: scale(36),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      child: const Icon(
        Icons.notifications_none,
        size: 20,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double scale(double v) => _scale(context, v);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: scale(430),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // --- Header Avatar Glass ---
          Positioned(
            top: scale(60),
            left: scale(16),
            right: scale(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(256),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: scale(66),
                  padding: EdgeInsets.symmetric(horizontal: scale(10)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(256),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: scale(55),
                            height: scale(55),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/avatar.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: scale(10)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Khuất Duy Quang',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: scale(16),
                                  height: 20 / 16,
                                  letterSpacing: 0,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              Text(
                                'Khách hàng',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: scale(12),
                                  height: 18 / 12,
                                  letterSpacing: 0,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      FutureBuilder<String?>(
                        future: AuthStorage.getRole(),
                        builder: (context, snapshot) {
                          final role = snapshot.data;
                          return _buildActionByRole(context, role, scale);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- Bottom content ---
          Positioned(
            bottom: scale(40),
            left: scale(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pill "Hy - Brid"
                Container(
                  width: scale(84),
                  height: scale(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: scale(12),
                          vertical: scale(4),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Hy - Brid',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w500,
                            fontSize: scale(11),
                            height: 1.4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scale(6)),
                Text(
                  'Bán hàng thật dễ dàng',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: scale(24),
                    height: 36 / 24,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: scale(10)),
                Container(
                  width: scale(148),
                  height: scale(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFED1C24),
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
                        color: Color(0x0FD1D1D1),
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
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamedAndRemoveUntil(
                        AppRoutes.welcomeScreen,
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Tham gia ngay',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w500,
                        fontSize: scale(13),
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: scale(18),
                        vertical: scale(8),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
