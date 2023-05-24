import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_source/canvas_exam/draggable_painter.dart';
import 'package:make_source/canvas_exam/drawing_model.dart';
import 'package:make_source/canvas_exam/edge_painter.dart';
import 'package:make_source/canvas_exam/node_painter.dart';
import 'dart:ui' as ui;

class CanvasExam extends StatefulWidget {
  const CanvasExam({super.key});

  @override
  State<CanvasExam> createState() => _CanvasExamState();
}

class _CanvasExamState extends State<CanvasExam> {
  final model = DrawingModel();

  var offsetX = 0.0;
  var offsetY = 0.0;

  var preX = 0.0;
  var preY = 0.0;

  NodePainter? currentNode;

  _CanvasExamState() {
    initNodes();
    initEdges();
  }

  void initNodes() {
    model.addNode(NodePainter(1, "Node\n1", 150.0, 210.0));
    model.addNode(NodePainter(2, "Node\n2", 220.0, 40.0));
    model.addNode(NodePainter(3, "Node\n3", 440.0, 240.0));
    model.addNode(NodePainter(4, "Node\n4", 640.0, 150.0));
    model.addNode(NodePainter(5, "Node\n5", 480.0, 350.0));
  }

  void initEdges() {
    model.addEdge(EdgePainter(1, 2));
    model.addEdge(EdgePainter(3, 2));
    model.addEdge(EdgePainter(5, 3));
    model.addEdge(EdgePainter(5, 4));
  }

  void _handlePanDown(details) {
    final x = details.localPosition.dx;
    final y = details.localPosition.dy;

    final node = model.getNode(x - offsetX, y - offsetY);
    if (node != null) {
      currentNode = node;
    } else {
      currentNode = null;
    }

    preX = x;
    preY = y;
  }

  void _handlePanUpdate(details) {
    final dx = details.localPosition.dx - preX;
    final dy = details.localPosition.dy - preY;

    if (currentNode != null) {
      setState(() {
        currentNode!.x = currentNode!.x + dx;
        currentNode!.y = currentNode!.y + dy;
      });
    } else {
      setState(() {
        offsetX = offsetX + dx;
        offsetY = offsetY + dy;
      });
    }

    preX = details.localPosition.dx;
    preY = details.localPosition.dy;
  }

  void _handleLongPressDown(details) {}

  void _handleLongPressMoveUpdate(details) {}

  //로컬에서 이미지 불러오기

  ui.Image? localImage;

  Future<ui.Image> imageFromFilePath(String filePath) async {
    var byteData = await rootBundle.load(filePath);
    Uint8List lst = Uint8List.view(byteData.buffer);
    var codec = await ui.instantiateImageCodec(lst);
    var nextFrame = await codec.getNextFrame();
    return nextFrame.image;
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  getImage() async {
    localImage = await imageFromFilePath('assets/images/outer.png');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onPanDown: _handlePanDown,
        onPanUpdate: _handlePanUpdate,
        onLongPressDown: _handleLongPressDown,
        onLongPressMoveUpdate: _handleLongPressMoveUpdate,
        /*
        onPanDown: _handlePanDown,
        onPanUpdate: _handlePanUpdate,
        */

        /*
        onPanDown: (detail) {
          preX = detail.localPosition.dx;
          preY = detail.localPosition.dy;
        },
        onPanUpdate: (detail) {
          setState(() {
            final dx = detail.localPosition.dx - preX;
            final dy = detail.localPosition.dy - preY;

            offsetX = offsetX + dx;
            offsetY = offsetY + dy;

            preX = detail.localPosition.dx;
            preY = detail.localPosition.dy;
          });
        },
        */

        child: localImage == null
            ? const SizedBox.shrink()
            : CustomPaint(
                painter: DraggablePainter(
                  model,
                  offsetX,
                  offsetY,
                  localImage!,
                ),
                child: Container(),
              ),
      ),
    );
  }
}
