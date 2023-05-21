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

    canvas.saveLayer(rect, Paint());

    for (var stroke in strokes) {
      Path strokePath = Path();

      strokePath.lineTo(
        stroke as double,
      );
      canvas.drawPath(strokePath, strokePaint);
    }

    // Customize the paint properties (color, stroke width, etc.)
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw the path onto the canvas
    canvas.drawPath(path!, paint);
    canvas.restore();
  }

  @override
  bool hitTest(Offset position) => true;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
