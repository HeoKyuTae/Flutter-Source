import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Interactive extends StatefulWidget {
  const Interactive({super.key});

  @override
  State<Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  final TransformationController _transformationController = TransformationController();

  bool zoom = false;
  double correctScaleValue = 1;

//view Size
  Size oriSize = const Size(428.0, 428.0);
  Size vSize = const Size(428.0, 428.0);
//image Size
  Size oriImgSize = const Size(0, 0);
  Size imgSize = const Size(0, 0);

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
    calcSize();
    setState(() {});
  }

  @override
  void initState() {
    _transformationController.value = Matrix4(
      1, 0, 0, 0, //
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );

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

  /*
calcSize() {
    if (widget.indexItems.ratio == 1.91) {
      imgSize = Size(Get.width, 0);
    } else {
      if (widget.indexItems.ratio == 0.8) {
        if (widget.indexItems.entity.size.aspectRatio > widget.indexItems.ratio) {
          imgSize = Size(0, Get.width);
        } else {
          imgSize = Size(widget.indexItems.size.width, 0);
        }
      } else {
        imgSize = Size(Get.width, 0);
      }
    }

    setState(() {});
  }

  */

  calcSize() {
    print('oriImgSize $oriImgSize');
    print('vSize $vSize');
    if (oriImgSize >= vSize) {
      print('if');
      imgSize = Size(0, vSize.height);
    } else if (oriImgSize <= vSize) {
      print('else if');
      imgSize = Size(0, vSize.width);
    } else {
      print('else');
      imgSize = Size(oriImgSize.width, 0);
    }

    setMatrix();
  }

  /*
  1:1
  width : vSize.width,
  height : null,

  4:5
  width: null,
  height: vSize.height,

  1.91:1
  width: imgSize.width,
  height: null,
  */

  @override
  Widget build(BuildContext context) {
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
                    child: Stack(
                  children: [
                    Center(
                      child: Container(
                          width: vSize.isEmpty ? oriSize.width : vSize.width,
                          height: vSize.isEmpty ? oriSize.height : vSize.height,
                          decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: correctScaleValue > 1 ? const NeverScrollableScrollPhysics() : null,
                            child: SingleChildScrollView(
                              physics: correctScaleValue > 1 ? const NeverScrollableScrollPhysics() : null,
                              child: InteractiveViewer(
                                // transformationController: _transformationController,
                                onInteractionStart: (details) {
                                  zoom = true;
                                  setState(() {});
                                },
                                onInteractionUpdate: (details) {
                                  correctScaleValue = _transformationController.value.getMaxScaleOnAxis();
                                  print(correctScaleValue);
                                  setState(() {});
                                },
                                onInteractionEnd: (details) {
                                  zoom = false;
                                  setState(() {});
                                },
                                minScale: 1,
                                maxScale: 10,
                                panEnabled: correctScaleValue > 1 ? true : false,
                                child: Image.asset(
                                  'assets/images/t.jpg',
                                  // 'assets/images/c.jpeg',
                                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                    if (frame != null) {
                                      oriImgSize = Size(context.width, context.height);

                                      calcSize();
                                    }
                                    return child;
                                  },
                                  width: imgSize.width == 0 ? null : imgSize.width,
                                  height: imgSize.height == 0 ? null : imgSize.height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Center(
                      child: Visibility(
                        visible: zoom,
                        child: Container(
                          width: vSize.isEmpty ? oriSize.width : vSize.width,
                          height: vSize.isEmpty ? oriSize.height : vSize.height,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.3))),
                          child: GridPaper(
                            color: Colors.white.withOpacity(0.3),
                            divisions: 1,
                            interval: vSize.isEmpty ? oriSize.width / 3 : vSize.width / 3,
                            subdivisions: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
