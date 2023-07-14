import 'dart:math';
import 'package:flutter/material.dart';

class SnowAnimation extends StatefulWidget {
  const SnowAnimation({super.key});

  @override
  State<SnowAnimation> createState() => _SnowAnimationState();
}

class _SnowAnimationState extends State<SnowAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> snowflakes;

  @override
  void initState() {
    super.initState();
    snowflakes = [Snowflake(x: 0, y: 0, size: 10, speed: 33)];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addListener(() {
        setState(() {
          updateSnowflakes();
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SnowPainter(
        snowflakes: snowflakes,
      ),
      child: Container(),
    );
  }

  void updateSnowflakes() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final snowflake = Snowflake(
      x: Random().nextDouble() * screenWidth,
      y: 0,
      size: Random().nextDouble() * 10 + 5,
      speed: Random().nextDouble() * 1 + 1,
    );
    snowflakes.add(snowflake);
    snowflakes.removeWhere((flake) => flake.y > screenHeight);
    for (var flake in snowflakes) {
      flake.y += flake.speed;
    }
  }
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> snowflakes;

  SnowPainter({required this.snowflakes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    for (var flake in snowflakes) {
      canvas.drawCircle(
        Offset(flake.x, flake.y),
        flake.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) {
    return snowflakes != oldDelegate.snowflakes;
  }
}

class Snowflake {
  double x;
  double y;
  double size;
  double speed;

  Snowflake({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
  });
}
