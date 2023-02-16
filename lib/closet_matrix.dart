import 'dart:math';

import 'package:flutter/material.dart';

class ClosetMatrix extends StatefulWidget {
  const ClosetMatrix({super.key});

  @override
  State<ClosetMatrix> createState() => _ClosetMatrixState();
}

class _ClosetMatrixState extends State<ClosetMatrix> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double flip = 0;
  bool isFlipped = false;

  @override
  void initState() {
    setController();
    super.initState();
  }

  setController() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: const Offset(0.0, -5.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat();
  }

  Widget transition(Widget widget, Animation<double> animation) {
    final flipAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
        animation: flipAnimation,
        child: widget,
        builder: (context, widget) {
          final isUnder = (ValueKey(isFlipped) != widget!.key);
          final value = isUnder ? min(flipAnimation.value, pi / 2) : flipAnimation.value;

          return Transform(
            transform: Matrix4.rotationX(value),
            child: widget,
            alignment: Alignment.center,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.000)
                  ..rotateY(flip),
                alignment: FractionalOffset.centerLeft,
                child: Container(
                  color: Colors.amber,
                  width: 100,
                  height: 100,
                  child: const Icon(
                    Icons.stacked_bar_chart,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              AnimatedSwitcher(
                reverseDuration: const Duration(seconds: 1),
                duration: const Duration(seconds: 1),
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                transitionBuilder: transition,
                child: Container(
                  color: Colors.amber,
                  width: 100,
                  height: 100,
                  child: const Icon(
                    Icons.stacked_bar_chart,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              SlideTransition(
                position: _animation,
                child: Transform.rotate(
                  // angle: pi / 4,
                  angle: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: const Icon(
                      Icons.stacked_bar_chart,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flip = flip == 0 ? pi : 0;
                          isFlipped = !isFlipped;
                        });
                      },
                      child: const Text('FLIP')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
