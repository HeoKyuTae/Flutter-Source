import 'dart:math';

import 'package:flutter/material.dart';

class ParticleAnimation extends StatefulWidget {
  const ParticleAnimation({super.key});

  @override
  State<ParticleAnimation> createState() => _ParticleAnimationState();
}

class _ParticleAnimationState extends State<ParticleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    particles = [
      Particle(position: const Offset(100, 100), radius: 50, angle: 15, speed: 10, color: Colors.amber),
    ];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: particles,
            progress: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.draw(canvas, size, progress);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return particles != oldDelegate.particles || progress != oldDelegate.progress;
  }
}

class Particle {
  Offset position;
  double radius;
  double angle;
  double speed;
  Color color;

  Particle({
    required this.position,
    required this.radius,
    required this.angle,
    required this.speed,
    required this.color,
  });

  void draw(Canvas canvas, Size size, double progress) {
    final paint = Paint()..color = color.withOpacity(1.0 - progress);
    final x = position.dx + cos(angle) * speed * progress;
    final y = position.dy + sin(angle) * speed * progress;
    canvas.drawCircle(
      Offset(x, y),
      radius * (1.0 - progress),
      paint,
    );
  }
}
