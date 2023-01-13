import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Interactive extends StatefulWidget {
  const Interactive({super.key});

  @override
  State<Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  final TransformationController _transformationController = TransformationController();

  bool zoom = false;
  double correctScaleValue = 1;

  Size oriSize = const Size(0, 0);
  Size vSize = const Size(0, 0);

  double aspectRatio = 1;
  String viewSize = '1:1';

  setViewSize(double widthRatio, double heightRatio) {
    if (widthRatio == 1.91) {
      viewSize = '$widthRatio:${heightRatio.toStringAsFixed(0)}';
    } else {
      viewSize = '${widthRatio.toStringAsFixed(0)}:${heightRatio.toStringAsFixed(0)}';
    }

    setAspectRatio(widthRatio / heightRatio);
    setState(() {});
  }

  setAspectRatio(double ratio) {
    aspectRatio = ratio;
    final newSize = Size(oriSize.width * aspectRatio, oriSize.height / aspectRatio);

    vSize = newSize;
    print(vSize);

    setMatrix();
    setState(() {});
  }

  @override
  void initState() {
    setMatrix();
    super.initState();
  }

  setMatrix() {
    _transformationController.value = Matrix4(
      1, 0, 0, 0, //
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );

    _transformationController.obs.refresh();
  }

  @override
  Widget build(BuildContext context) {
    oriSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);
    // vSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setViewSize(1.0, 1.0);
                          },
                          child: const Text('1:1')),
                      ElevatedButton(
                          onPressed: () {
                            setViewSize(4.0, 5.0);
                          },
                          child: const Text('4:5')),
                      ElevatedButton(
                          onPressed: () {
                            setViewSize(1.91, 1.0);
                          },
                          child: const Text('1.91:1')),
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Container(
                      width: vSize.isEmpty ? oriSize.width : vSize.width,
                      height: vSize.isEmpty ? oriSize.height : vSize.height,
                      decoration: BoxDecoration(border: Border.all(width: 10)),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: UnconstrainedBox(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.asset(
                                // 'assets/images/t.jpg',
                                'assets/images/c.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
