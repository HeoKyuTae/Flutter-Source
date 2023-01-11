import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class MatrixView extends StatefulWidget {
  const MatrixView({super.key});

  @override
  State<MatrixView> createState() => _MatrixViewState();
}

class _MatrixViewState extends State<MatrixView> {
  /*
  Matrix

  scaleX + cos(x), 0, -sin(x), 0,
  -sin(x), scaleY + cons(x), sin(x), 0,
  0, -sin(x), scaleZ + cos(x), 0,
  translateX, translateY, translateZ, All_Scale,

  */

  double x = 0;
  double y = 0;
  double z = 0;

  double xx = 0;
  double yy = 0;
  double zz = 0;

  double boxSize = 100;
  double angle = 0;
  double scale = 1;

  double baseAngle = 0;
  double angleDelta = 0;

  // var matrix = Matrix4(
  //   1, 0, 0, 0, //
  //   0, 1, 0, 0,
  //   0, 0, 1, 0,
  //   0, 0, 0, 1,
  // );

  var matrix = Matrix4(
    1, 0, 0, 0, //
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1,
  );

  int sincosX = 0;

  @override
  void initState() {
    super.initState();
  }

  double i = 0.00000000009;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          color: Colors.amber,
          child: Column(
            children: [
              Container(
                  color: Colors.blue,
                  width: size.width,
                  height: size.width,
                  child: ClipRRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          width: boxSize,
                          height: boxSize,
                          color: Colors.blueGrey,
                          child: Stack(
                            children: [
                              Transform(
                                origin: Offset(size.width, size.width),
                                transform: matrix
                                  ..setTranslationRaw(x, y, z)
                                  ..scale(scale, scale, scale)
                                  ..setRotationX(angle)
                                  ..setRotationY(angle)
                                  ..setRotationZ(angle)
                                // transform: matrix = Matrix4(
                                //   1 + math.cos(i), 0, -math.sin(i), i, //
                                //   -math.sin(i), 1 + math.cos(i), math.sin(i), i,
                                //   0, -math.sin(i), 1 + math.cos(i), 0,
                                //   0, 0, 0, 1,
                                // )
                                // transform: matrix = Matrix4(
                                //   scale + cos(sincosX), 0, -sin(sincosX), 0, //
                                //   -sin(sincosX), scale + cos(sincosX), sin(sincosX), 0,
                                //   0, -sin(sincosX), scale + cos(sincosX), 0,
                                //   x, y, 0, scale,
                                // )
                                // ..rotateX(0)
                                // ..rotateY(0)
                                // ..rotateZ(angle),
                                ,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          x = math.max(0, x + details.delta.dx);
                                          y = math.max(0, y + details.delta.dy);
                                        });
                                      },
                                      child: Container(
                                        width: boxSize * scale,
                                        height: boxSize * scale,
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '!',
                                          style:
                                              TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          xx = math.max(0, xx + details.delta.dx);
                                          yy = math.max(0, yy + details.delta.dy);
                                        });
                                      },
                                      child: Container(
                                        width: boxSize * scale,
                                        height: boxSize * scale,
                                        color: Colors.red,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '!',
                                          style:
                                              TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onPanStart: (details) {
                                    final center = Offset(
                                      -((boxSize / 2)),
                                      (boxSize / 2),
                                    );

                                    final touchPositionFromCenter = details.localPosition - center;
                                    angleDelta = baseAngle - touchPositionFromCenter.direction;
                                  },
                                  onPanUpdate: (details) {
                                    final center = Offset(
                                      -((boxSize / 2)),
                                      (boxSize / 2),
                                    );

                                    final touchPositionFromCenter = details.localPosition - center;

                                    setState(
                                      () {
                                        angle = touchPositionFromCenter.direction + angleDelta;
                                        print(angle);
                                      },
                                    );
                                  },
                                  onPanEnd: (details) {
                                    baseAngle = angle;
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onPanUpdate: (DragUpdateDetails details) {
                                    setState(() {
                                      // widget.item.size = Size(widget.item.size.width + details.delta.dx, widget.item.size.height);
                                      // var angle = widget.item.rotation;
                                      // var rotationalOffset = Offset(cos(angle) - 1, sin(angle)) * details.delta.dx / 2;
                                      // widget.item.offset += rotationalOffset;

                                      // widget.item.size = Size(widget.item.size.width, widget.item.size.height + details.delta.dy);
                                      // var angle = widget.item.rotation;
                                      // var rotationalOffset = Offset(-sin(angle), cos(angle) - 1) * details.delta.dy / 2;
                                      // widget.item.offset += rotationalOffset;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.amber,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
