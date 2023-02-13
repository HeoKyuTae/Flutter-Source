import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class PngToJpg extends StatefulWidget {
  const PngToJpg({super.key});

  @override
  State<PngToJpg> createState() => _PngToJpgState();
}

class _PngToJpgState extends State<PngToJpg> {
  File? file;

  @override
  void initState() {
    getImage();
    super.initState();
  }

  getImage() async {
    final imageData = await rootBundle.loadString('assets/images/bag.png');
    final image = img.decodeImage(File(imageData).readAsBytesSync())!;

    File('thumbnail.jpg').writeAsBytesSync(img.encodeJpg(image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
