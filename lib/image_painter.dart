import 'package:flutter/material.dart';

class ImagePainter extends CustomPainter {
  List<Offset> strokes;

  ImagePainter({
    required this.strokes,
  });

  Path? path;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.saveLayer(rect, Paint());

    for (var stroke in strokes) {
      Path strokePath = Path();

      print(stroke);

      strokePath.lineTo(
        stroke.dx,
        stroke.dy,
      );
      canvas.drawPath(strokePath, paint);
    }

    // Customize the paint properties (color, stroke width, etc.)

    // Draw the path onto the canvas
    // canvas.drawPath(path!, paint);
    canvas.restore();
  }
/*
  Future<ui.Image> _renderImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = DrawImage(image: _image, controller: _controller);
    final size = Size(_image!.width.toDouble(), _image!.height.toDouble());
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }
*/

  @override
  bool hitTest(Offset position) => true;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
