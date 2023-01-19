import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class Rotate extends StatefulWidget {
  const Rotate({super.key});

  @override
  State<Rotate> createState() => _RotateState();
}

class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  Random random = Random();

  late AnimationController controller;
  late Animation<double> translation;
  late Animation<double> rotation;

  bool isShow = false;

  double rotateValue = 0.0;

  _buildText(double angle, {required Color color, required String text}) {
    final double rad = math.radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        color: Colors.cyan,
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 900), vsync: this);

    translation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

    rotation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.7,
        )));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: rotateValue,
              duration: const Duration(milliseconds: 2000),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, builder) {
                  return Transform.rotate(
                    angle: math.radians(rotation.value),
                    child: Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
                      _buildText(0, color: Colors.red, text: 'aaa'),
                      _buildText(45, color: Colors.blue, text: 'bbb'),
                      _buildText(90, color: Colors.amber, text: 'ccc'),
                      _buildText(135, color: Colors.green, text: 'ddd'),
                      _buildText(180, color: Colors.yellow, text: 'eee'),
                      _buildText(225, color: Colors.pink, text: 'fff'),
                      _buildText(270, color: Colors.orange, text: 'ggg'),
                      _buildText(315, color: Colors.purple, text: 'hhh'),
                    ]),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: (() {
                  setState(() {
                    isShow ? controller.forward() : controller.reverse();
                    isShow = !isShow;
                  });
                }),
                child: const Text('send')),
            ElevatedButton(
                onPressed: (() {
                  setState(() {
                    rotateValue = random.nextDouble() * 125;
                    print(rotateValue.toDouble().ceilToDouble());
                  });
                }),
                child: const Text('rotate'))
          ],
        ),
      ),
    );
  }
}
