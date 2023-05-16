import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';

class Painter extends StatefulWidget {
  const Painter({super.key});

  @override
  State<Painter> createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  late ui.Image image;
  late ui.Image image1;
  bool isImageloaded = false;

  Future<ui.Image> _loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 300,
      targetWidth: 300,
    );
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  void initState() {
    cacheImage('assets/images/transparent.png');
    super.initState();
  }

  Future<void> cacheImage(String asset) async {
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
      backgroundColor: Colors.amber,
      body: Center(
        child: Container(
          width: size.width,
          height: size.width,
          child: Stack(
            children: [
              Image.asset('assets/images/transparent.png'),
              FutureBuilder<ui.Image>(
                future: _loadImage('assets/images/outer.png'),
                builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('Image loading...');
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Center(
                          child: CustomPaint(
                            // painter: ImagePainter(
                            //   image1,
                            // ),
                            foregroundPainter: ImagePainter(
                              snapshot.data!,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: size.width,
                              height: size.width,
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final recorder = ui.PictureRecorder();

  ImagePainter(
    this.image,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    double radius = 80.0;

    final Paint eraserPaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    canvas.saveLayer(rect, Paint());

    canvas.drawImage(
      image,
      Offset.zero,
      Paint(),
    );

    canvas.drawCircle(const Offset(150, 150), radius, eraserPaint);
    canvas.saveLayer(rect, Paint());
    canvas.restore();
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return true;
  }
}

enum PaintChoice {
  paint,
  eraser,
  masking,
}

class PathHistory {
  late Offset points;
  late Paint paint;
  late PaintChoice choice;
  late ui.Image image;
  final double devicePixelRatio = ui.window.devicePixelRatio;

  PathHistory({
    required Offset offset,
    required ui.Image image,
    required PaintChoice paintChoice,
    required Color color,
    required double strokeWidth,
  }) {
    choice = paintChoice;
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
  void addPoint(
      {required Offset offset,
      required PaintChoice choice,
      required ui.Image image,
      required Color color,
      double strokeWidth = 10}) {
    pathHistory
        .add(PathHistory(offset: offset, paintChoice: choice, image: image, color: color, strokeWidth: strokeWidth));
    notifyListeners();
  }

  void clear() {
    pathHistory.clear();
    notifyListeners();
  }
}
