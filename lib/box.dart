import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  const Box({super.key});

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  late Size widgetSize;
  late Offset offset;
  late Offset pos;

  bool isPos = false;
  bool isShow = false;

  //TextBox
  late Size textBoxSize;
  late Offset textBoxOffset;
  late Offset textBoxPos;

  @override
  void initState() {
    widgetSize = const Size(50, 50);
    offset = const Offset(0, 0);
    pos = const Offset(0, 0);

    //TextBox
    textBoxSize = const Size(100, 100);
    textBoxOffset = const Offset(100, 150);
    textBoxPos = const Offset(100, 150);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Container(
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(color: Colors.amber, border: Border.all()),
            child: Stack(
              children: [
                Positioned(
                  top: offset.dy,
                  left: isShow == true
                      ? offset.dx
                      : isPos == false
                          ? offset.dx
                          : offset.dx - 100,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Row(
                      children: [
                        isPos == false
                            ? Container()
                            : isShow == true
                                ? Container()
                                : Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    child: const Text('TAG'),
                                  ),
                        GestureDetector(
                          onPanStart: (details) {
                            pos = details.localPosition;
                            isShow = true;
                            print(pos);
                            setState(() {});
                          },
                          onPanUpdate: (details) {
                            offset = Offset(details.globalPosition.dx - pos.dx,
                                details.globalPosition.dy - (pos.dy + statusBarHeight));
                            // print(offset);

                            if (offset.dx > (size.width / 2)) {
                              isPos = true;
                            } else {
                              isPos = false;
                            }

                            print(isPos);
                            setState(() {});
                          },
                          onPanEnd: (details) {
                            isShow = false;
                            setState(() {});
                          },
                          child: Container(
                            width: widgetSize.width,
                            height: widgetSize.height,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        isPos == true
                            ? Container()
                            : isShow == true
                                ? Container()
                                : Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.green,
                                    alignment: Alignment.center,
                                    child: const Text('TAG'),
                                  ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: textBoxOffset.dy,
                    left: textBoxOffset.dx,
                    child: GestureDetector(
                      onPanStart: (details) {
                        textBoxPos = details.localPosition;
                        print(textBoxPos);
                        setState(() {});
                      },
                      onPanUpdate: (details) {
                        textBoxOffset = Offset(details.globalPosition.dx - textBoxPos.dx,
                            details.globalPosition.dy - (textBoxPos.dy + statusBarHeight));
                        print(textBoxOffset);
                        setState(() {});
                      },
                      child: Container(
                        width: textBoxSize.width,
                        color: Colors.red,
                        child: Stack(
                          children: [
                            const Text('Connecting to VM Service at ws://127.0.0.1:63308/BoLDeUcjiqg=/ws'),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  print(details.globalPosition.dx);

                                  setState(() {
                                    textBoxSize = Size(details.globalPosition.dx, details.globalPosition.dy);
                                  });
                                },
                                child: Container(
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
