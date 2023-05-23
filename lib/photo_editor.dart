import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_source/image_painter.dart';

class PhotoEditor extends StatefulWidget {
  const PhotoEditor({super.key});

  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  late final TransformationController _transformationController;

  List<Offset?> strokes = [];
  ui.Image? image;
  List<int> touch = [];

  bool isLock = false;
  bool isFlip = false;
  bool isPaint = false;

  double rotate = 0.0;
  double brightness = 0.0;
  double saturation = 0.0;
  double contrast = 0.0;

  double markScale = 1;
  int markX = 0;
  int markY = 0;

  @override
  void initState() {
    _transformationController = TransformationController();
    cacheImage('assets/images/outer.png');
    super.initState();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Future<void> cacheImage(String asset) async {
    try {
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      ui.FrameInfo fi = await codec.getNextFrame();

      setState(() {
        image = fi.image;
      });
    } catch (e) {
      print(e);
    }
  }

  void _scaleEndGesture(ScaleEndDetails onEnd) {
    markScale = _transformationController.value.getMaxScaleOnAxis();
    print(markScale);

    markX = _transformationController.value.getTranslation().x.ceil();
    markY = _transformationController.value.getTranslation().y.ceil();

    print(_transformationController.value.getTranslation().x.ceil());
    print(_transformationController.value.getTranslation().y.ceil());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset('assets/images/transparent.png'),
                        Container(
                          width: size.width,
                          height: size.width,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: isFlip ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
                            child: Listener(
                              onPointerUp: (event) {
                                setState(() {
                                  isLock = false;
                                  touch = [];
                                });
                              },
                              onPointerDown: (event) {
                                if (touch.length == 2) {
                                  setState(() {
                                    isLock = true;
                                    // controller.lock();
                                  });
                                } else {
                                  if (!touch.contains(event.pointer)) {
                                    setState(() {
                                      isLock = false;
                                      touch.add(event.pointer);
                                    });
                                  }
                                }
                              },
                              onPointerMove: (event) {
                                if (touch.length == 2) {
                                  setState(() {
                                    isLock = true;
                                    // controller.lock();
                                  });
                                } else {
                                  setState(() {});
                                }
                              },
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  setState(() {
                                    strokes = List.from(strokes)..add(details.localPosition);
                                  });
                                },
                                onPanEnd: (details) {
                                  setState(() {
                                    strokes = List.of(strokes)..add(null);
                                  });
                                },
                                child: image != null
                                    ? InteractiveViewer(
                                        minScale: 1,
                                        maxScale: 2,
                                        panEnabled: true,
                                        scaleEnabled: true,
                                        onInteractionEnd: _scaleEndGesture,
                                        child: Transform.rotate(
                                          angle: pi * (rotate / 180),
                                          child: CustomPaint(
                                            painter: ImagePainter(
                                              strokes: strokes,
                                              image: image!,
                                              rotate: rotate,
                                              brightness: brightness,
                                              saturation: saturation,
                                              contrast: contrast,
                                              flip: isFlip,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 8, 1, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                                  child: Image.asset(
                                    'assets/images/straighten.png',
                                    width: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${rotate.toInt()}',
                                    style: TextStyle(
                                      color: rotate != 0 ? Colors.red : Colors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    activeColor: rotate == 0 ? Colors.black.withOpacity(0.3) : Colors.red,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    value: rotate,
                                    min: -180,
                                    max: 180,
                                    label: rotate.round().toString(),
                                    divisions: 100,
                                    onChangeStart: (value) {},
                                    onChanged: (double value) {
                                      setState(() {
                                        rotate = value;
                                      });
                                    },
                                    onChangeEnd: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 8, 1, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                                  child: Image.asset(
                                    'assets/images/brightness.png',
                                    width: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${brightness.toInt()}',
                                    style: TextStyle(
                                      color: brightness != 0 ? Colors.red : Colors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    activeColor: brightness == 0 ? Colors.black.withOpacity(0.3) : Colors.red,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    value: brightness,
                                    min: -50,
                                    max: 50,
                                    label: brightness.round().toString(),
                                    divisions: 100,
                                    onChangeStart: (value) {},
                                    onChanged: (double value) {
                                      setState(() {
                                        brightness = value;
                                      });
                                    },
                                    onChangeEnd: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 8, 1, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                                  child: Image.asset(
                                    'assets/images/contrast.png',
                                    width: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    contrast.toStringAsFixed(2),
                                    style: TextStyle(
                                      color: contrast != 0 ? Colors.red : Colors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    activeColor: contrast == 0 ? Colors.black.withOpacity(0.3) : Colors.red,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    value: contrast,
                                    min: -1,
                                    max: 1,
                                    label: contrast.toStringAsFixed(2),
                                    divisions: 100,
                                    onChangeStart: (value) {},
                                    onChanged: (double value) {
                                      setState(() {
                                        contrast = value;
                                      });
                                    },
                                    onChangeEnd: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 8, 1, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                                  child: Image.asset(
                                    'assets/images/saturation.png',
                                    width: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    saturation.toStringAsFixed(2),
                                    style: TextStyle(
                                      color: saturation != 0 ? Colors.red : Colors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    activeColor: saturation == 0 ? Colors.black.withOpacity(0.3) : Colors.red,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    value: saturation,
                                    min: -1,
                                    max: 1,
                                    label: saturation.toStringAsFixed(2),
                                    divisions: 100,
                                    onChangeStart: (value) {},
                                    onChanged: (double value) {
                                      setState(() {
                                        saturation = value;
                                      });
                                    },
                                    onChangeEnd: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isFlip = !isFlip;
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/images/flip.png',
                                      width: 25,
                                      color: isFlip ? Colors.red : Colors.black,
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isPaint = !isPaint;
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: isPaint ? Colors.red : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
