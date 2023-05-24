import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:make_source/canvas_exam/drawing_model.dart';

class DraggablePainter extends CustomPainter {
  static const gridWidth = 50.0;
  static const gridHeight = 50.0;
  final radius = 30.0;

  var _width = 0.0;
  var _height = 0.0;

  final double offsetX;
  final double offsetY;

  final DrawingModel model;

  DraggablePainter(this.model, this.offsetX, this.offsetY);

  void _drawBackground(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white70
      ..isAntiAlias = true;

    Rect rect = Rect.fromLTWH(0, 0, _width, _height);
    canvas.drawRect(rect, paint);
  }

  void _drawGrid(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..isAntiAlias = true;

    final gridRect = Rect.fromLTWH(
        offsetX % gridWidth - gridWidth, offsetY % gridHeight - gridHeight, _width + gridWidth, _height + gridHeight);

    final rows = _height / gridHeight;
    final cols = _width / gridWidth;

    for (int r = -1; r <= rows; r++) {
      final y = r * gridHeight + gridRect.top;
      final p1 = Offset(gridRect.left, y);
      final p2 = Offset(gridRect.right, y);

      canvas.drawLine(p1, p2, paint);
    }

    for (int c = -1; c <= cols; c++) {
      final x = c * gridWidth + gridRect.left;
      final p1 = Offset(x, gridRect.top);
      final p2 = Offset(x, gridRect.bottom);

      canvas.drawLine(p1, p2, paint);
    }
  }

  Offset? _getCenterPosOfNode(nodeId) {
    for (final node in model.getNodeList()) {
      if (nodeId == node.id) {
        return Offset(node.x, node.y);
      }
    }
    return null;
  }

  void _drawEdges(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 2
      ..isAntiAlias = true;

    for (final edge in model.getEdgeList()) {
      final fromPos = _getCenterPosOfNode(edge.fromId);
      final toPos = _getCenterPosOfNode(edge.toId);

      if ((fromPos != null) && (toPos != null)) {
        final distance = Offset(toPos.dx - fromPos.dx, toPos.dy - fromPos.dy).distance - radius;
        final theta = atan2((toPos.dy - fromPos.dy), (toPos.dx - fromPos.dx));
        final targetX = fromPos.dx + distance * cos(theta);
        final targetY = fromPos.dy + distance * sin(theta);

        var path = Path();
        path.moveTo(fromPos.dx, fromPos.dy);
        path.lineTo(targetX, targetY);
        path = ArrowPath.make(path: path);
        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawNodes(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber
      ..isAntiAlias = true;

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (final node in model.getNodeList()) {
      final c = Offset(node.x, node.y);
      canvas.drawCircle(c, radius, paint);
      _drawText(canvas, node.x, node.y, node.name, textStyle);
    }
  }

  void _drawText(Canvas canvas, centerX, centerY, text, style) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final xCenter = (centerX - textPainter.width / 2);
    final yCenter = (centerY - textPainter.height / 2);
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);

    // rotateCanvas(
    //   canvas: canvas,
    //   cx: xCenter,
    //   cy: yCenter,
    //   angle: 1,
    // );
  }

  void rotateCanvas({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  void _drawCanvas(Canvas canvas) {
    _drawBackground(canvas);
    _drawGrid(canvas);

    canvas.save();
    canvas.translate(offsetX, offsetY);

    _drawEdges(canvas);
    _drawNodes(canvas);

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _width = size.width;
    _height = size.height;

    _drawCanvas(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
