import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.phaseText,
    required this.accessoryText,
    required this.imageProvider,
    required this.quantity,
    this.onAdd,
    this.onRemove,
  });

  final String title;
  final String phaseText;      // "Hệ điện: 1 pha"
  final String accessoryText;  // "Phụ kiện: ..."
  final ImageProvider imageProvider;
  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 398,
      height: 162,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x26D1D1D1), blurRadius: 34, offset: Offset(0, 15)),
            BoxShadow(color: Color(0x21D1D1D1), blurRadius: 61, offset: Offset(0, 61)),
            BoxShadow(color: Color(0x14D1D1D1), blurRadius: 82, offset: Offset(0, 137)),
            BoxShadow(color: Color(0x0DD1D1D1), blurRadius: 98, offset: Offset(0, 244)),
            BoxShadow(color: Color(0x00D1D1D1), blurRadius: 107, offset: Offset(0, 382)),
          ],
        ),
        child: SizedBox(
          width: 366,
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // nội dung chính
              SizedBox(
                width: 366,
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GradientBorderImage(imageProvider: imageProvider),
                    const SizedBox(width: 12),
                    // thông tin
                    SizedBox(
                      width: 273,
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 20 / 14,
                              fontWeight: FontWeight.w600, // ~590
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Hệ điện
                          SizedBox(
                            width: 273,
                            height: 18,
                            child: Text(
                              phaseText,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 18 / 13,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Phụ kiện
                          SizedBox(
                            width: 273,
                            height: 36,
                            child: Text(
                              accessoryText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 18 / 13,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // tăng/giảm số lượng
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _QtyPill(
                    quantity: quantity,
                    onAdd: onAdd,
                    onRemove: onRemove,
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

class _GradientBorderImage extends StatelessWidget {
  const _GradientBorderImage({required this.imageProvider});

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    // Khung 81×81, bo góc 12, viền gradient 1px, bóng mờ 0 0 12
    return Container(
      width: 81,
      height: 81,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 12)],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // mô phỏng border gradient bằng lớp bọc 1px
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1), // border-width:1
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0x00FFFFFF),
                  Color(0xB3FFFFFF), // ~0.7 opacity
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: imageProvider,
                  width: 41, // 81 - padding ngang 40
                  height: 61, // 81 - padding dọc 20
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QtyPill extends StatelessWidget {
  const _QtyPill({
    required this.quantity,
    this.onAdd,
    this.onRemove,
  });

  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 28,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIcon(
            icon: Icons.remove,
            onTap: onRemove,
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4F4F4F)),
          ),
          _circleIcon(
            icon: Icons.add,
            onTap: onAdd,
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFFDD3B30)), // đỏ nhẹ như mẫu
      ),
    );
  }
}
