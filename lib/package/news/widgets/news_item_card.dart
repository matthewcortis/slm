import 'package:flutter/material.dart';
import '../model/card_item_model.dart';
 

class NewsCardCard extends StatelessWidget {
  final CardItemModel news;
  const NewsCardCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail-news');
      },
      child: Container(
        width: 295,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
            BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
            BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
            BoxShadow(color: Color(0x0DD1D1D1), blurRadius: 98, offset: Offset(0, 244)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Image.asset(
                    news.image,
                    width: 371,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 371,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const RadialGradient(
                        center: Alignment.center,
                        radius: 0.75,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(0, 0, 0, 0.2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    news.tag,
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF4F4F4F),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  news.time,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF828282),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
