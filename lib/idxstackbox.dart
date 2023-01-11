import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class IdxStackBox extends StatelessWidget {
  final ScreenshotController screenshotController;
  final Color color;
  const IdxStackBox({super.key, required this.color, required this.screenshotController});

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        width: 100,
        height: 100,
        color: color,
      ),
    );
  }
}
