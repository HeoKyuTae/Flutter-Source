import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:make_source/fast_img_resize.dart' as fir;

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
    ByteData imageData = await rootBundle.load('assets/images/item.jpg');
    Uint8List bytes = Uint8List.view(imageData.buffer);

    img.Image? receiptImage = img.decodeImage(bytes);

    img.Image? thumbnail = img.copyResize(
      receiptImage!,
      width: receiptImage.width,
      height: receiptImage.height,
      interpolation: img.Interpolation.cubic,
    );

    var newJpg = img.encodeJpg(thumbnail, quality: 100);

    final dir = await getImageDirectory(subDirectory: 'image');
    file = File('$dir/image_${DateTime.now().millisecondsSinceEpoch}.jpg')..writeAsBytesSync(newJpg);

    resizeImage(file!);

    setState(() {});
  }

  resizeImage(File file) async {
    ///
    final rawImage = await file.readAsBytes();
    ByteData? byteData = await fir.resizeImage(
      Uint8List.view(rawImage.buffer),
      width: 725,
      height: 725,
    );

    ///
    ///
    Uint8List bytes = Uint8List.view(byteData!.buffer);

    img.Image? image = img.decodeImage(bytes);

    img.Image? thumbnail = img.copyResize(
      image!,
      width: image.width,
      height: image.height,
      interpolation: img.Interpolation.cubic,
    );

    var newJpg = img.encodeJpg(thumbnail, quality: 100);

    // Save the thumbnail as a PNG.
    final dir = await getImageDirectory(subDirectory: 'resize');
    resizefile = File('$dir/resize_${DateTime.now().millisecondsSinceEpoch}.jpg')..writeAsBytesSync(newJpg);

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
    Size size = MediaQuery.of(context).size;

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
