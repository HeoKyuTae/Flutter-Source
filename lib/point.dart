import 'package:flutter/material.dart';

class TLPosition {
  late double top;
  late double left;
  TLPosition({required this.top, required this.left});
}

// ignore: must_be_immutable
class PointP extends StatelessWidget {
  final GlobalKey globalKey;
  late TLPosition tlPosition;
  PointP({super.key, required this.tlPosition, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: globalKey,
      top: tlPosition.top,
      left: tlPosition.left,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            // color: Color.fromARGB(
            //   _random.nextInt(256),
            //   _random.nextInt(256),
            //   _random.nextInt(256),
            //   _random.nextInt(256),
            // ),
            color: Colors.black,
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
