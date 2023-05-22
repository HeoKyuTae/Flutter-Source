import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:make_source/image_painter.dart';

class PhotoEditor extends StatefulWidget {
  const PhotoEditor({super.key});

  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  List<Offset> strokes = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: size.width,
          decoration: BoxDecoration(color: Colors.amber, border: Border.all(color: Colors.grey.withOpacity(0.3))),
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // Update the list of points with the current touch position
                strokes = List.from(strokes)..add(details.localPosition);
              });
            },
            onPanEnd: (details) {
              setState(() {
                // Clear the points list when the gesture ends
                // points.clear();
              });
            },
            child: CustomPaint(
              painter: ImagePainter(strokes: strokes),
            ),
          ),
        ),
      ),
    );
  }
}
