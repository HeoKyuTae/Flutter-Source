import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PaintChoice {
  paint,
  eraser,
  masking,
}

class CacheImage extends StatefulWidget {
  const CacheImage({super.key});

  @override
  State<CacheImage> createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage> {
  PaintController _paintController = new PaintController();
  PaintChoice choice = PaintChoice.paint;
  Color pickerColor = Colors.red;
  Color currentColor = Colors.red;
  double _value = 10;
  late ui.Image image;
  late ui.Image image1;

  @override
  void initState() {
    super.initState();
    cacheImage('assets/images/transparent.png');
    cacheImage1('assets/images/remove.png');
  }

  Future<void> cacheImage(String asset) async {
    try {
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      image = fi.image;
      print(image);
    } catch (e) {
      print(e);
    }
  }

  Future<void> cacheImage1(String asset) async {
    try {
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      image1 = fi.image;
      print(image1);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 48,
                color: Colors.black,
              ),
              Container(
                color: Colors.transparent,
                width: size.width,
                height: size.width,
                child: Stack(
                  children: [
                    CustomPaint(
                      child: RepaintBoundary(
                        child: GestureDetector(
                          onPanUpdate: (s) {
                            Offset pos = (context.findRenderObject() as RenderBox).globalToLocal(s.globalPosition);
                            _paintController.addPoint(
                                offset: pos, choice: choice, image: image1, color: pickerColor, strokeWidth: _value);
                          },
                          onPanEnd: (e) {
                            print('drag end');
                            // _paintController.addPoint(
                            //     offset: null, choice: choice, color: pickerColor, image: image, strokeWidth: _value);
                          },
                        ),
                      ),
                      painter: _Paint(controller: _paintController, repaint: _paintController),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1,
                color: Colors.black,
              ),
              Expanded(child: Container()),
              Slider(
                semanticFormatterCallback: (double d) {
                  return '${d.round()} strokeWidth';
                },
                onChanged: (s) {
                  setState(() {
                    _value = s;
                  });
                },
                value: _value,
                max: 50,
                min: 0.0,
                // divisions: 5,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/image.jpg'),
                      child: IconButton(
                          tooltip: 'Masking effect',
                          disabledColor: pickerColor,
                          onPressed: () {
                            choice = PaintChoice.masking;
                          },
                          icon: Icon(Icons.format_paint)),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          tooltip: 'Eraser',
                          disabledColor: pickerColor,
                          onPressed: () {
                            choice = PaintChoice.eraser;
                          },
                          icon: Icon(Icons.phonelink_erase)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Paint extends CustomPainter {
  _Paint({required this.controller, required Listenable repaint}) : super(repaint: repaint);
  PaintController controller;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (int i = 0; i < controller.pathHistory.length - 1; i++) {
      if (controller.pathHistory[i].points != null && controller.pathHistory[i + 1].points != null) {
        canvas.drawLine(
            controller.pathHistory[i].points, controller.pathHistory[i + 1].points, controller.pathHistory[i].paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_Paint oldDelegate) => oldDelegate.controller.pathHistory != controller.pathHistory;
}

class PathHistory {
  late Offset points;
  late Paint paint;
  late PaintChoice paintChoice;
  late ui.Image image;
  final double devicePixelRatio = ui.window.devicePixelRatio;

  PathHistory({
    required Offset offset,
    required ui.Image image,
    required PaintChoice paintChoice,
    required Color color,
    required double strokeWidth,
  }) {
    this.paintChoice = paintChoice;
    points = offset;
    final Float64List deviceTransform = Float64List(16)
      ..[0] = devicePixelRatio
      ..[5] = devicePixelRatio
      ..[10] = 1.0
      ..[15] = 3.5;
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth
      ..color = color;
    switch (paintChoice) {
      case PaintChoice.paint:
        break;
      case PaintChoice.masking:
        paint.shader = ImageShader(image, TileMode.repeated, TileMode.repeated, deviceTransform);
        break;
      case PaintChoice.eraser:
        paint.blendMode = BlendMode.clear;
    }
  }
}

class PaintController extends ChangeNotifier {
  List<PathHistory> pathHistory = [];
  void addPoint({
    required Offset offset,
    required PaintChoice choice,
    required ui.Image image,
    required Color color,
    double strokeWidth = 10,
  }) {
    pathHistory
        .add(PathHistory(offset: offset, paintChoice: choice, image: image, color: color, strokeWidth: strokeWidth));
    notifyListeners();
  }

  void clear() {
    pathHistory.clear();
    notifyListeners();
  }
}
