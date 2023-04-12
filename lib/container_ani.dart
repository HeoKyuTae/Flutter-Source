import 'dart:math' as math;

import 'package:flutter/material.dart';

class ContainerAni extends StatefulWidget {
  const ContainerAni({super.key});

  @override
  State<ContainerAni> createState() => _ContainerAniState();
}

class _ContainerAniState extends State<ContainerAni> with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;

  bool isPos = false;

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //destory anmiation to free memory on last
  }

  draw() {
    return Drawer(
      child: SafeArea(
        child: Container(
          width: 100,
          color: Colors.red,
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: draw(),
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: size.height * 0.5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                    Color(0xffe06478),
                    Color(0xfffcdd89),
                  ])),
                ),
                builder: (context, child) {
                  return ClipPath(
                    clipper: MyWaveClipper(_controller.value),
                    child: child,
                  );
                },
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 300,
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                print('ElevatedButton');
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: null),
                        ),
                        SizedBox(
                          width: 100,
                          height: 200,
                          child: AbsorbPointer(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade200,
                                ),
                                onPressed: () {
                                  print('AbsorbPointer');
                                },
                                child: null),
                          ),
                        ),
                      ],
                    ),
                  )),
              AnimatedPositioned(
                  top: isPos ? 100 : 0,
                  left: isPos ? 200 : 0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceIn,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPos = !isPos;
                      });
                    },
                    child: Banner(
                      message: '10% off',
                      location: BannerLocation.topEnd,
                      child: Container(
                        transform: Matrix4.rotationZ(isPos ? 0.5 : 0),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                        ),
                        child: const Baseline(
                          baseline: -8,
                          baselineType: TextBaseline.alphabetic,
                          child: FlutterLogo(
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                top: 300,
                left: 100,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                  child: OverflowBox(
                    minWidth: 200,
                    maxWidth: size.width - 100,
                    minHeight: 100,
                    maxHeight: 200,
                    child: Container(
                      width: size.width * 2,
                      height: 50,
                      color: Colors.amberAccent.withOpacity(0.2),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyWaveClipper extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  double point = 0.8;
  MyWaveClipper(this.move);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter = size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * point);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
