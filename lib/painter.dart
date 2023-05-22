import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'dart:async';
import 'dart:typed_data';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:path_provider/path_provider.dart';

class Painter extends StatefulWidget {
  const Painter({super.key});

  @override
  State<Painter> createState() => _PainterState();
}

class _PainterState extends State<Painter> with SingleTickerProviderStateMixin {
  final statusbarHeight = MediaQueryData.fromWindow(ui.window).padding.top;
  final bottomHeight = MediaQueryData.fromWindow(ui.window).padding.bottom;

  ui.Image? image;
  bool isImageloaded = false;

  double scale = 1.0;
  double rotate = 0.0;
  double brightness = 0.0;
  double saturation = 0.0;
  double contrast = 0.0;

  bool isFlip = false;
  Offset offset = const Offset(0, 0);
  Size cropSize = const Size(0, 0);
  bool isSave = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      cacheImage('assets/images/flower.jpeg', MediaQuery.of(context).size);
      print('size: ${MediaQuery.of(context).size}');
    });

    super.initState();
  }

  Future<void> cacheImage(String asset, Size size) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: size.width.toInt(),
      targetHeight: size.width.toInt(),
    );
    var frame = await codec.getNextFrame();
    image = frame.image;

    print(image);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
              ),
              Container(
                width: size.width,
                height: size.width,
                child: Stack(
                  children: [
                    Image.asset('assets/images/transparent.png'),
                    image != null
                        ? InteractiveViewer(
                            minScale: 1,
                            maxScale: 2,
                            // panEnabled: _controller.mode == PaintMode.none,
                            child: Center(
                              child: CustomPaint(
                                size: size,
                                willChange: true,
                                isComplex: true,
                                foregroundPainter: ImagePainter(
                                  image!,
                                  rotate,
                                  brightness,
                                  saturation,
                                  contrast,
                                  scale,
                                  isFlip,
                                  offset,
                                  cropSize,
                                  isSave,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size.width,
                                  height: size.width,
                                ),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFlip = !isFlip;
                              });
                            },
                            child: const Text('Flip')),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                offset = const Offset(0, 0);
                                cropSize = const Size(300, 100);
                              });
                            },
                            child: const Text('Crop Rect')),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                offset = const Offset(0, 0);
                                cropSize = const Size(0, 0);
                                isSave = false;
                              });
                            },
                            child: const Text('복원')),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isSave = true;
                              });
                            },
                            child: const Text('저장')),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Scale'),
                        Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          thumbColor: Colors.white,
                          value: scale,
                          min: 1,
                          max: 3,
                          label: scale.toInt().toString(),
                          divisions: 2,
                          onChangeStart: (value) {},
                          onChanged: (double value) {
                            setState(() {
                              scale = value;
                            });
                          },
                          onChangeEnd: (value) {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('회전'),
                        Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.withOpacity(0.3),
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
                      ],
                    ),
                    Column(
                      children: [
                        Text('밝기'),
                        Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.withOpacity(0.3),
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
                      ],
                    ),
                    Column(
                      children: [
                        Text('채도'),
                        Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          thumbColor: Colors.white,
                          value: saturation,
                          min: -1,
                          max: 1,
                          label: saturation.toString(),
                          divisions: 100,
                          onChangeStart: (value) {},
                          onChanged: (double value) {
                            setState(() {
                              saturation = value;
                            });
                          },
                          onChangeEnd: (value) {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('대비'),
                        Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          thumbColor: Colors.white,
                          value: contrast,
                          min: -1,
                          max: 1,
                          label: contrast.toString(),
                          divisions: 100,
                          onChangeStart: (value) {},
                          onChanged: (double value) {
                            setState(() {
                              contrast = value;
                            });
                          },
                          onChangeEnd: (value) {},
                        ),
                      ],
                    ),
                  ]),
                ),
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
  final double rotate;
  final double brightness;
  final double saturation;
  final double contrast;
  final double scale;
  final bool flip;
  final Offset offset;
  final Size cropSize;
  final bool save;

  ImagePainter(
    this.image,
    this.rotate,
    this.brightness,
    this.saturation,
    this.contrast,
    this.scale,
    this.flip,
    this.offset,
    this.cropSize,
    this.save,
  );

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    var rect = Offset.zero & size;

    if (cropSize != const Size(0, 0)) {
      rect = offset & cropSize;
    }

    double radius = 80.0;

    //brightness 명도
    // double brightness = 0; //-50 ~ 50

    //saturation 채도
    // double saturation = 0; //0.0 ~ 1.0
    double x = 1 + saturation;
    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.0820;

    //contrast 대비
    // double contrast = 0; //0.0 ~ 1.0

    final Paint eraserPaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    canvas.saveLayer(rect, Paint());

    var matrixTranform = Matrix4Transform();
    var origin = Offset(size.width / 2, size.width / 2);

    matrixTranform = matrixTranform.rotateDegrees(rotate, origin: origin);

    if (flip) {
      matrixTranform = matrixTranform.flipHorizontally(origin: origin);
    }

    matrixTranform = matrixTranform.scale(scale, origin: origin);

    canvas.transform(matrixTranform.matrix4.storage);

    final Paint filter = Paint()
      ..colorFilter = ColorFilter.matrix([
        lumR * (1 - x) + x + contrast,
        lumG * (1 - x),
        lumB * (1 - x), 0, brightness,
        lumR * (1 - x - contrast) / 2,
        lumG * (1 - x) + x + contrast,
        lumB * (1 - x), 0, brightness,
        lumR * (1 - x - contrast) / 2,
        lumG * (1 - x),
        lumB * (1 - x) + x + contrast, 0, brightness,
        (1 - contrast) / 2, 0, 0, 1, 0, //
      ]);

    canvas.drawImage(
      image,
      Offset.zero,
      filter,
    );

    canvas.drawCircle(Offset(size.width / 1.5, size.width / 2), radius, eraserPaint);

    var r = Offset(offset.dx * scale, offset.dy * scale) & cropSize * scale;

    if (save == true && !r.isEmpty) {
      getPng(
        r,
        filter,
        matrixTranform,
      );
    }

    canvas.restore();
  }

  Future<ui.Image> getPng(Rect rect, Paint paint, Matrix4Transform matrixTranform) async {
    var c = Canvas(recorder);

    c.saveLayer(rect, Paint());
    c.clipRect(rect);
    c.transform(matrixTranform.matrix4.storage);
    c.drawImage(image, offset, paint);

    var picture = recorder.endRecording();

    ui.Image i = await picture.toImage(cropSize.width.round(), cropSize.height.round());
    ByteData? byteData = await i.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    final dir = (await getApplicationDocumentsDirectory()).path;
    final imagePath = await File('$dir/cut_image${DateTime.now().millisecondsSinceEpoch}.png').create();
    imagePath.writeAsBytes(imageBytes!);

    print(imagePath);
    final cropImage = await picture.toImage(rect.width.toInt(), rect.height.toInt());
    return cropImage;
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
