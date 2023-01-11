import 'package:flutter/material.dart';

class Sticker extends StatefulWidget {
  final Size size;
  final Offset offset;
  final Color color;
  const Sticker({super.key, required this.size, required this.offset, required this.color});

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  GlobalKey globalKey = GlobalKey();

  Size? boxSize;
  Offset? offset;
  Color? color;

  @override
  void initState() {
    boxSize = widget.size;
    offset = widget.offset;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: globalKey,
      left: offset!.dx,
      top: offset!.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          var statusBarHeight = MediaQuery.of(context).viewPadding.top;
          // double adjustment = MediaQuery.of(context).size.height - constraints.maxHeight;

          double distance = boxSize!.width / 2;

          setState(() {
            offset = Offset(details.globalPosition.dx - distance, details.globalPosition.dy - boxSize!.width);
            print(offset);
          });
        },
        child: Container(
          width: boxSize!.width,
          height: boxSize!.width,
          color: color,
        ),
      ),
    );
  }
}
