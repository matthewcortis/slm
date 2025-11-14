import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../page/customer_screen.dart';

class BankContractCard extends StatefulWidget {
  const BankContractCard({Key? key}) : super(key: key);

  @override
  State<BankContractCard> createState() => _BankContractCardState();
}

class _BankContractCardState extends State<BankContractCard>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //  CARD 1 — ngân hàng, giữ chiều cao cố định
        _buildMainCard(scale),

        //CARD 2 — mở rộng (tách riêng, không nằm trong card 1)
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isExpanded ? _buildExpandedCard(scale) : const SizedBox(),
        ),

        // ✅ NÚT MŨI TÊN
        SizedBox(height: scale(10)),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width: scale(32),
            height: scale(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              ],
            ),
            child: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.red,
                size: scale(24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //  CARD NGÂN HÀNG 
  Widget _buildMainCard(Function(double) scale) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(scale(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: scale(398),
            padding: EdgeInsets.all(scale(16)),
            decoration: BoxDecoration(
              color: const Color(0x33E6E6E6),
              borderRadius: BorderRadius.circular(scale(20)),
              border: Border.all(color: Colors.white, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26D1D1D1),
                  blurRadius: 15,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              children: [
             
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tài khoản ngân hàng",
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 20 / 14,
                        color: const Color(0xFF848484),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Techcombank",
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 20 / 14,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                        SizedBox(height: scale(4)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "0123456789",
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 20 / 14,
                                color: const Color(0xFF4F4F4F),
                              ),
                            ),
                            SizedBox(width: scale(6)),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  const ClipboardData(text: "0123456789"),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Đã sao chép số tài khoản"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/icons/copy.svg",
                                width: scale(20),
                                height: scale(20),
                                colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(255, 255, 0, 0),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: scale(10)),

               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TAG ngày bàn giao + label
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TAG
                        Container(
                          width: scale(174),
                          height: scale(22),
                          padding: EdgeInsets.symmetric(
                            vertical: scale(3),
                            horizontal: scale(8),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x33E6E6E6),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Ngày bàn giao:",
                                style: TextStyle(
                                  fontFamily: "SF Pro",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  height: 12 / 10,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                              SizedBox(width: scale(2)),
                              Text(
                                "12/03/2025",
                                style: TextStyle(
                                  fontFamily: "SF Pro",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  height: 12 / 10,
                                  color: const Color(0xFF4F4F4F),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: scale(4)),

                        Text(
                          "Tổng giá trị hợp đồng",
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            height: 20 / 14,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "12.650.000",
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w600,
                            fontSize: scale(22),
                            height: 1.0,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: scale(6)),
                        Icon(
                          Icons.visibility_outlined,
                          size: scale(20),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ CARD MỞ RỘNG 
  Widget _buildExpandedCard(Function(double) scale) {
    return Container(
      width: scale(398),
      height: scale(99),
      margin: EdgeInsets.only(top: scale(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CustomerListScreen(), 
                ),
              );
            },
            child: _buildSmallInfoCard(
              scale,
              title: "Danh sách khách hàng",
              value: "12",
            ),
          ),

          _buildSmallInfoCard(
            scale,
            title: "Tổng số hoa hồng",
            value: "100.000.000đ",
          ),
        ],
      ),
    );
  }

  // ✅ CARD CON 191 × 97
  Widget _buildSmallInfoCard(
    Function(double) scale, {
    required String title,
    required String value,
  }) {
    return Container(
      width: scale(191),
      height: scale(99),
      padding: EdgeInsets.all(scale(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6E6E6), 
          width: 1,
        ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w400, 
              fontSize: 14,
              height: 20 / 14,
              letterSpacing: 0,
              color: const Color(0xFF4F4F4F),
            ),
          ),
          SizedBox(height: scale(8)), 

          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              fontSize: scale(22),
              height: 1.0,
              letterSpacing: 0,
              color: const Color(0xFFEE4037), 
            ),
          ),
        ],
      ),
    );
  }
}
