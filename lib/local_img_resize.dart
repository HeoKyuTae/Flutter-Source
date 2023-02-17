import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class LocalImgResize extends StatefulWidget {
  const LocalImgResize({super.key});

  @override
  State<LocalImgResize> createState() => _LocalImgResizeState();
}

class _LocalImgResizeState extends State<LocalImgResize> {
  File? file;
  File? resizefile;

  @override
  void initState() {
    getImage();
    super.initState();
  }

  getImage() async {
    // var imageData = await rootBundle.load('asset/images/item.jpg');
    // Image _receiptImage = await img.decodeImage(new File(imageData).readAsBytesSync());

    ByteData imageData = await rootBundle.load('assets/images/item.jpg');
    List<int> bytes = Uint8List.view(imageData.buffer);
    img.Image? receiptImage = img.decodeImage(bytes);

    var newjpeg = img.encodeJpg(receiptImage as img.Image);

    final dir = await getImageDirectory(subDirectory: 'image');
    file = await File('$dir/image_${DateTime.now().millisecondsSinceEpoch}.png').writeAsBytes(newjpeg);
    print("file: $file");

    resizeImage(file!);
    setState(() {});

    // /Users/mac/Library/Developer/CoreSimulator/Devices/E2DE9D2B-828C-41DF-BC3E-1F382498BD8B/data/Containers/Data/Application/2CC83ABD-E1F0-4649-8E79-85232EEC2203/Library/Caches/'
  }

  resizeImage(File file) async {
    img.Image? image = img.decodeImage(file.readAsBytesSync());

    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).

    img.Image? thumbnail = img.copyResize(
      image!,
      width: image.width,
      height: image.height,
      interpolation: img.Interpolation.nearest,
    );

    // Save the thumbnail as a PNG.
    final dir = await getImageDirectory(subDirectory: 'resize');
    resizefile = File('$dir/resize_${DateTime.now().millisecondsSinceEpoch}.png')
      ..writeAsBytesSync(img.encodeJpg(thumbnail, quality: 20), flush: true);

    setState(() {});
  }

  Future<String> getImageDirectory({String subDirectory = ''}) async {
    final rootDir = await getTemporaryDirectory();
    var dir = '${rootDir.path}/image';
    if (subDirectory.isNotEmpty) {
      dir = '$dir/$subDirectory';
    }

    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return dir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                file == null ? const SizedBox.shrink() : Image.file(file!),
                resizefile == null ? const SizedBox.shrink() : Image.file(resizefile!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
