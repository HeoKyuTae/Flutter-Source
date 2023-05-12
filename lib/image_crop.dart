import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart' as imgsize;
import 'package:path_provider/path_provider.dart';

class ImgCropper extends StatefulWidget {
  const ImgCropper({super.key});

  @override
  State<ImgCropper> createState() => _ImgCropperState();
}

class _ImgCropperState extends State<ImgCropper> {
  final TransformationController _transformationController = TransformationController();
  XFile? imageFile;
  File? croppedFile;
  Size? size;
  Rectangle<int>? rectangle;
  double posY = 0;
  double posX = 0;

  double? aspectRatio;

  Size _size = const Size(0, 0);

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

  gallery() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    size = foo(File(image!.path));

    imageFile = image;
    File crop = File(await getFaceFromImage(File(imageFile!.path)));

    print(crop);

    setState(() {});
  }

  crop() async {
    File crop = File(await getFaceFromImage(File(imageFile!.path)));
    print(crop);
  }

  Future<String> getFaceFromImage(File imageFile) async {
    // final image = await imageFile.readAsBytes();
    // final decodedImage = img.decodeImage(image);

    var decodedImage = await decodeImageFromList(File(imageFile.path).readAsBytesSync());
    print('original width : ${decodedImage.width}');
    print('original height : ${decodedImage.height}');

    rectangle = Rectangle(posX.toInt(), posY.toInt(), decodedImage.width, decodedImage.height);

    print(rectangle);

    final imageBytes = img.decodeImage(File(imageFile.path).readAsBytesSync())!;

    final face = img.copyCrop(
      imageBytes,
      x: posX.toInt(),
      y: posY.toInt(),
      width: decodedImage.width,
      height: decodedImage.height,
    );

    final dir = await getImageDirectory(subDirectory: 'mask');
    final localFilePath = '$dir/mask_1.png';
    File file = File(localFilePath);

    if (file.existsSync()) {
      file.createSync(recursive: true);
    }
    File mergedFile = await file.writeAsBytes(img.encodePng(face));

    return mergedFile.path;
  }

  foo(File file) {
    final size = imgsize.ImageSizeGetter.getSize(FileInput(file));
    if (size.needRotate) {
      final width = size.height;
      final height = size.width;
      print('width = $width, height = $height');
      return Size(width.toDouble(), height.toDouble());
    } else {
      print('width = ${size.width}, height = ${size.height}');
      return Size(size.width.toDouble(), size.height.toDouble());
    }
  }

  // calcSize() {
  //   if (aspectRatio == 1.91 / 1) {
  //     _size = Size(Get.width, 0);
  //   } else {
  //     if (aspectRatio == 4 / 5) {
  //       if (widget.assetModel.entity.orientatedSize.aspectRatio > widget.aspectRatio) {
  //         _size = Size(0, Get.width);
  //       } else {
  //         _size = Size(widget.viewSize.width, 0);
  //       }
  //     } else {
  //       if (widget.assetModel.entity.orientatedSize.aspectRatio > widget.aspectRatio) {
  //         _size = Size(0, Get.width);
  //       } else {
  //         _size = Size(Get.width, 0);
  //       }
  //     }
  //   }

  //   print(_size);
  // }

  @override
  void initState() {
    _transformationController.value = Matrix4(
      1, 0, 0, 0, //
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );

    _transformationController.obs.refresh();

    // calcSize();
    super.initState();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.width,
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        imageFile == null
                            ? const SizedBox.shrink()
                            : InteractiveViewer(
                                transformationController: _transformationController,
                                minScale: 1,
                                maxScale: 10,
                                // constrained: false,
                                child: Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.cover,
                                  width: size.width,
                                  height: size.height,
                                )),
                      ],
                    ),
                  ),
                  // rectangle != null
                  //     ? Positioned(
                  //         top: 0,
                  //         left: 0,
                  //         child: Container(
                  //           width: rectangle!.width.toDouble(),
                  //           height: rectangle!.width.toDouble(),
                  //           color: Colors.red.withOpacity(0.5),
                  //         ),
                  //       )
                  //     : const SizedBox.shrink()
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gallery();
                        });
                      },
                      child: const Text('gallery')),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          crop();
                        });
                      },
                      child: const Text('crop')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
