import 'dart:math';

import 'package:flutter/material.dart';

class Canvas extends StatefulWidget {
  const Canvas({super.key});

  @override
  State<Canvas> createState() => _CanvasState();
}

class _CanvasState extends State<Canvas> {
  List<GlobalKey> position = [];
  List<GlobalKey> container = [];
  List<Widget> box = [];
  List<Map<String, double>> loc = [];

  double top = 0;
  double left = 0;

  @override
  void initState() {
    initBox();
    super.initState();
  }

  initBox() {
    setState(() {
      box.add(xbox());
      loc.add({'top': 0, 'left': 0});
    });
  }

  Widget xbox() {
    GlobalKey globalPositionKey = GlobalKey();
    GlobalKey globalBoxKey = GlobalKey();

    position.add(globalPositionKey);
    container.add(globalBoxKey);

    return Positioned(
      key: globalPositionKey,
      top: top,
      left: left,
      child: GestureDetector(
        key: globalBoxKey,
        onPanStart: (details) {
          setState(() {
            var p = loc[container.indexOf(globalBoxKey)];
            top = p['top']!;
            left = p['left']!;
            print('top : $top // left : $left');
          });
        },
        onPanUpdate: (details) {
          setState(() {
            top = top + details.delta.dx;
            left = left + details.delta.dy;
            setLoc(Size(top, left), globalPositionKey, globalBoxKey);
          });
        },
        child: Container(
          width: 50,
          height: 50,
          color: randomColor(),
        ),
      ),
    );
  }

  setLoc(Size size, GlobalKey posKey, GlobalKey boxKey) {
    setState(() {
      loc[container.indexOf(boxKey)] = {'top': top, 'left': left};
      box[container.indexOf(boxKey)] = w(size, posKey, boxKey);
    });
  }

  Widget w(Size size, GlobalKey pos, GlobalKey box) {
    return Positioned(
        key: pos,
        top: size.width,
        left: size.height,
        child: GestureDetector(
          onPanStart: (details) {
            setState(() {
              var p = loc[container.indexOf(box)];
              top = p['top']!;
              left = p['left']!;
              print('top : $top // left : $left');
            });
          },
          onPanUpdate: (details) {
            setState(() {
              top = top + details.delta.dy;
              left = left + details.delta.dx;
              setLoc(Size(top, left), pos, box);
            });
          },
          child: Container(
            key: box,
            width: 50,
            height: 50,
            color: randomColor(),
          ),
        ));
  }

  Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.amber,
                height: 48,
                child: const Text('HEADER'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                          color: Colors.white, width: size.width, height: size.width, child: Stack(children: box)),
                      Container(
                        alignment: Alignment.center,
                        color: Colors.green,
                        height: 100,
                        child: TextButton(
                            onPressed: () {
                              initBox();
                            },
                            child: const Text(
                              '위젯 추가',
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Container(
                        height: 1000,
                        color: Colors.black,
                      )
                    ],
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
