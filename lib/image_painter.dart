import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImagePainter extends CustomPainter {
  List<Offset?> strokes;
  ui.Image image;

  final double rotate;
  final double brightness;
  final double saturation;
  final double contrast;
  final bool flip;

  ImagePainter({
    required this.strokes,
    required this.image,
    required this.rotate,
    required this.brightness,
    required this.saturation,
    required this.contrast,
    required this.flip,
  });

  Path? path;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    double x = 1 + saturation;
    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.0820;

    final Paint filter = Paint();

    final colorFilter = ColorFilter.matrix([
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

    filter.colorFilter = colorFilter;

    Paint paint = Paint()
      ..blendMode = BlendMode.clear
      ..color = Colors.transparent
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.saveLayer(rect, Paint());

    // rotateCanvas(
    //     canvas: canvas,
    //     cx: size.width.toDouble() / 2,
    //     cy: size.height.toDouble() / 2,
    //     angle: flip ? -pi * (rotate / 180) : pi * (rotate / 180));

    //Image
    paintImage(
      canvas: canvas,
      image: image,
      // flipHorizontally: flip,
      filterQuality: FilterQuality.high,
      rect: Rect.fromPoints(
        const Offset(0, 0),
        Offset(size.width, size.height),
      ),
      colorFilter: colorFilter,
    );

    //drawLine
    for (int i = 0; i < strokes.length - 1; i++) {
      if (strokes[i] != null && strokes[i + 1] != null) {
        canvas.drawLine(strokes[i]!, strokes[i + 1]!, paint);
      }
    }

    canvas.restore();
  }

/*
  Future<void> saveFile(
    Canvas canvas,
    ui.PictureRecorder recorder,
    Size size,
    ui.Image image,
    Paint filter,
    double rotate,
    bool flip,
    ColorFilter colorFilter,
  ) async {
    var c = Canvas(recorder);

    var r = Rect.fromPoints(
      const Offset(0, 0),
      Offset(
        image.width.toDouble(),
        image.height.toDouble(),
      ),
    );

    c.saveLayer(r, Paint());
    c.clipRect(r);
    rotateCanvas(
        canvas: c,
        cx: size.width.toDouble() / 2,
        cy: size.height.toDouble() / 2,
        angle: flip ? -pi * (rotate / 180) : pi * (rotate / 180));

    // c.drawImage(image, Offset.zero, filter);

    paintImage(
      canvas: c,
      image: image,
      flipHorizontally: flip,
      filterQuality: FilterQuality.high,
      rect: Rect.fromPoints(
        const Offset(0, 0),
        Offset(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
      ),
      colorFilter: colorFilter,
      isAntiAlias: true,
    );

    for (MapEntry<Path, Paint> path in _paths) {
      Paint eraserPaint = path.value;

      if (flip) {
        c.scale(-1, 1);
        c.translate(-size.width, 0);
      }
      c.drawPath(path.key, eraserPaint);
    }

    ui.Image renderedImage = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());

    final byteData = await renderedImage.toByteData(format: ImageByteFormat.png);

    final imageBytes = byteData?.buffer.asUint8List();

    final dir = await getImageDirectory(subDirectory: 'cut');

    final imagePath = await File('$dir/cut_image${DateTime.now().millisecondsSinceEpoch}.png').create();

    img.Image? deImage = img.decodeImage(imageBytes!);

    final resized = img.copyResize(
      deImage!,
      width: image.width.round(),
      height: image.height.round(),
    );

    printDebug(resized);

    Uint8List resizedImg = Uint8List.fromList(img.encodePng(resized));

    printDebug(imagePath.path);
    File file = await imagePath.writeAsBytes(resizedImg, flush: true);
    Get.back(result: file);
  }
*/
  void rotateCanvas({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  @override
  bool hitTest(Offset position) => true;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
