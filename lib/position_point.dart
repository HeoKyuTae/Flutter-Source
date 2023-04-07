import 'dart:math';
import 'package:flutter/material.dart';
import 'package:make_source/point.dart';

class PositionPoint extends StatefulWidget {
  const PositionPoint({super.key});

  @override
  State<PositionPoint> createState() => _PositionPointState();
}

class _PositionPointState extends State<PositionPoint> {
  GlobalKey pointKey = GlobalKey();
  double size = 150;
  final Random _random = Random();

  List<PointP> list = [];

  double top = 0;
  double left = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSize);

    for (var i = 0; i < 10; i++) {
      list.add(PointP(
        globalKey: GlobalKey(),
        tlPosition: TLPosition(top: _random.nextInt(256).toDouble(), left: _random.nextInt(256).toDouble()),
      ));
    }

    super.initState();
  }

  void _getSize(_) {
    print(pointKey.currentContext);
    // Size? keySize = pointKey.currentContext?.;
    // print(keySize);

    RenderBox box = pointKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double x = position.dx;
    double y = position.dy;
    print(x);
    print(y);
    final size = box.size;
    print(size);
  }

  zeroPoint() {
    for (var i = 0; i < list.length; i++) {
      print('Get item : ${list[i]}');
      list[i].tlPosition.top = 0;
      list[i].tlPosition.left = 0;

      print('Set item : ${list[i]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 44,
                    height: 44,
                    color: Colors.amber,
                  )),
              Container(
                key: pointKey,
                child: Center(
                  child: Container(
                    width: size,
                    height: size,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(size)),
                  ),
                ),
              ),
              // point(top, left),
              Stack(
                fit: StackFit.expand,
                children: list,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 44,
                  color: Colors.grey.withOpacity(0.1),
                  child: ElevatedButton(
                      onPressed: () {
                        zeroPoint();
                        setState(() {});
                      },
                      child: const Text('Random Position')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
