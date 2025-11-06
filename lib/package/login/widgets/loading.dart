import 'package:flutter/material.dart';

class ExpandingCircleScreen extends StatefulWidget {
  const ExpandingCircleScreen({super.key});

  @override
  State<ExpandingCircleScreen> createState() => _ExpandingCircleScreenState();
}

class _ExpandingCircleScreenState extends State<ExpandingCircleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Bắt đầu animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Đường kính cần đủ lớn để phủ toàn màn hình
    final maxRadius = size.height * 1.2;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Nền ban đầu (trắng hoặc ảnh)
          Container(color: Colors.white),

          // Hình tròn loang ra
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: maxRadius * _animation.value,
                height: maxRadius * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade500,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
