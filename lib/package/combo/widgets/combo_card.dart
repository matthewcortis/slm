import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandCard extends StatelessWidget {
  final String iconPath; 
  final String text;
  final VoidCallback? onTap;
  const BrandCard({
    super.key,
    required this.iconPath,
    required this.text, 
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 191,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6), // var(--Color-Gray-100)
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
        boxShadow: const [
          BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
          BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
          BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
          BoxShadow(color: Color(0x0DD1D1D1), blurRadius: 98, offset: Offset(0, 244)),
          BoxShadow(color: Color(0x00D1D1D1), blurRadius: 107, offset: Offset(0, 382)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            GestureDetector(
            onTap: onTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6).withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
                  BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
                  BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
                  BoxShadow(color: Color(0x0DD1D1D1), blurRadius: 98, offset: Offset(0, 244)),
                  BoxShadow(color: Color(0x00D1D1D1), blurRadius: 107, offset: Offset(0, 382)),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Color(0xFFEE4037), BlendMode.srcIn),
                ),
              ),
            ),
          ),
   
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 20 / 12,
              color: Color(0xFF4F4F4F), // var(--Color-Gray-700)
            ),
          ),
        ],
      ),
    );
  }
}
