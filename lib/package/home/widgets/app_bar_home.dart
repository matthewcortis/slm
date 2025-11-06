import 'dart:ui';
import 'package:flutter/material.dart';

class SolarHeaderFullCard extends StatelessWidget {
  const SolarHeaderFullCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 430.0;
    double scale(double v) => v * screenWidth / baseWidth;

    return Container(
      width: screenWidth,
      height: scale(430),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
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
                  height: scale(56),
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
                            width: scale(48),
                            height: scale(48),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
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
                                  fontFamily:
                                      'SF Pro', // hoặc 'SF Pro Display' nếu bạn đã add font
                                  fontWeight: FontWeight
                                      .w600, // tương đương Semibold ~ 590
                                  fontStyle: FontStyle.normal,
                                  fontSize: scale(14),
                                  height: 20 / 14, // line-height: 20px
                                  letterSpacing: 0,
                                  color: const Color(
                                    0xFF4F4F4F,
                                  ), // var(--Color-Gray-700)
                                ),
                              ),
                              Text(
                                'Khách hàng',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w400, // Regular
                                  fontStyle: FontStyle.normal,
                                  fontSize: scale(12),
                                  height: 18 / 12, // line-height: 18px
                                  letterSpacing: 0,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
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
                // Bên trong Stack (ví dụ Positioned ở phần bottom)
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
                          color: Colors.white.withOpacity(
                            0.25,
                          ), // glass trong suốt
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.white.withOpacity(
                              0.4,
                            ), // viền nhẹ kiểu iOS
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
                    fontFamily:
                        'SF Pro', // hoặc 'SF Pro Display' nếu bạn đã add font
                    fontWeight: FontWeight.w600, // tương đương Semibold (~590)
                    fontStyle: FontStyle.normal,
                    fontSize: scale(24), // Figma: 24px
                    height: 36 / 24, // line-height: 36px
                    letterSpacing: 0, // letter-spacing: 0px
                    color: Colors.white, // background: #FFFFFF (text màu trắng)
                  ),
                ),

                SizedBox(height: scale(10)),
                Container(
                  width: scale(148),
                  height: scale(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFED1C24),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x26D1D1D1), // #D1D1D126
                        blurRadius: 34,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: const Color(0x21D1D1D1), // #D1D1D121
                        blurRadius: 61,
                        offset: const Offset(0, 61),
                      ),
                      BoxShadow(
                        color: const Color(0x14D1D1D1), // #D1D1D114
                        blurRadius: 82,
                        offset: const Offset(0, 137),
                      ),
                      BoxShadow(
                        color: const Color(0x0FD1D1D1), // #D1D1D105
                        blurRadius: 98,
                        offset: const Offset(0, 244),
                      ),
                      BoxShadow(
                        color: const Color(0x00D1D1D1), // #D1D1D100
                        blurRadius: 107,
                        offset: const Offset(0, 382),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
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
                      backgroundColor:
                          Colors.transparent, // vì Container có màu rồi
                      shadowColor:
                          Colors.transparent, // tắt shadow mặc định của button
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

class ContractValueCard extends StatelessWidget {
  const ContractValueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
          rootNavigator: false,
        ).pushNamed('/warranty');
      },

      child: Center(
        child: Container(
          width: scale(398),
          height: scale(93),
          padding: EdgeInsets.all(scale(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF3F3F3), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000), // #0000001F
                blurRadius: 20,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT SIDE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Capsule "Ngày bàn giao"
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: scale(8),
                      vertical: scale(4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33E6E6E6), // #E6E6E633
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFF3F3F3)),
                    ),
                    child: Text(
                      'Ngày bàn giao: 12/03/2025',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        fontSize: scale(10),
                        height: 18 / 12,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                  SizedBox(height: scale(8)),
                  // Label “Tổng giá trị hợp đồng”
                  Text(
                    'Tổng giá trị hợp đồng',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 20 / 14,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                ],
              ),

              // RIGHT SIDE
              Row(
                children: [
                  Text(
                    '12.650.000',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600, // Semibold ~ 590
                      fontSize: scale(24),
                      height: 30 / 24,
                      color: const Color(0xFFEE4037), // đỏ thương hiệu
                    ),
                  ),
                  SizedBox(width: scale(6)),
                  const Icon(
                    Icons.visibility_outlined,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
