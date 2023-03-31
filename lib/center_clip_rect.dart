import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CenterClipRect extends StatefulWidget {
  const CenterClipRect({super.key});

  @override
  State<CenterClipRect> createState() => _CenterClipRectState();
}

class _CenterClipRectState extends State<CenterClipRect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                color: Colors.amber,
                alignment: Alignment.center,
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  minScale: 1,
                  maxScale: 2.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: Image.asset(
                      'assets/images/123.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width * 0.45))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
