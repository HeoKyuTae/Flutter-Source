import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_byte/image_to_byte.dart';
import 'package:flutter/material.dart';
import 'package:exif/exif.dart';
import 'package:lottie/lottie.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

class ColorMatrix extends StatefulWidget {
  const ColorMatrix({super.key});

  @override
  State<ColorMatrix> createState() => _ColorMatrixState();
}

class _ColorMatrixState extends State<ColorMatrix> with TickerProviderStateMixin {
  List<Filter> filters = presetFiltersList;
  Map<String, List<int>?> cachedFilters = {};

  img.Image? image;
  String? fileName;

  double brightnessValue = 0;

  late AnimationController _bellController;
  final ImagePicker picker = ImagePicker();
  late File imageFile;

  @override
  void initState() {
    print(image);
    _bellController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    super.initState();
  }

/*
  getImage() async {
    var flower = const Image(image: AssetImage('assets/images/flower.jpeg'));

    var url = 'https://scaffoldtecnologia.com.br/wp-content/uploads/2021/11/i257652.jpeg';

    Uint8List iByte = await imageToByte(url);
    Map<String, IfdTag> data = await readExifFromBytes(iByte, details: true);

    if (data == null || data.isEmpty) {
      print('No EXIF infomation');

      return;
    }

    for (String key in data.keys) {
      print('$key ${data[key]!.tagType} : ${data[key]}');
    }
  }
*/

  Future getImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      fileName = basename(imageFile.path);
      var imgFile = img.decodeImage(await imageFile.readAsBytes());
      imgFile = img.copyResize(imgFile!, width: 500);

      cachedFilters = {};
      setState(() {
        image = imgFile!;
      });
      print(image);
    }
  }

  @override
  void dispose() {
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 48,
                  color: Colors.blue.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        alignment: Alignment.center,
                        splashRadius: 50,
                        iconSize: 50,
                        onPressed: () {
                          print(_bellController.status);
                          if (_bellController.isAnimating) {
                            // _bellController.stop();
                            _bellController.reset();
                          } else {
                            _bellController.repeat();
                          }
                        },
                        icon: Lottie.asset(LottieFiles.$33262_icons_bell_notification,
                            controller: _bellController, width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        splashRadius: 50,
                        iconSize: 50,
                        onPressed: () {
                          getImage(context);
                        },
                        icon: const Icon(Icons.camera),
                      ),
                    ],
                  )),
              Expanded(
                child: Center(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.matrix(<double>[
                        1, 0, 0, 0, brightnessValue,
                        0, 1, 0, 0, brightnessValue,
                        0, 0, 1, 0, brightnessValue,
                        0, 0, 0, 1, 0, //
                      ]),
                      child: Image.asset('assets/images/flower.jpeg')),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              image == null
                  ? Container()
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Container(
                                        child: buildFilterThumbnail(filters[index], image, fileName),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        filters[index].name.toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (brightnessValue <= -20) {
                                  brightnessValue = -20;
                                } else {
                                  brightnessValue -= 10;
                                }
                              });
                            },
                            child: const Text('-')),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(brightnessValue == 0 ? '원본' : '$brightnessValue'),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (brightnessValue >= 20) {
                                  brightnessValue = 20;
                                } else {
                                  brightnessValue += 10;
                                }
                              });
                            },
                            child: const Text('+')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildFilterThumbnail(Filter filter, img.Image? image, String? filename) {
    if (cachedFilters[filter.name] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": image,
          "filename": filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                width: 50,
                height: 50,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 0.1,
                  ),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter.name] = snapshot.data;
              return Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundImage: MemoryImage(
                    snapshot.data as dynamic,
                  ),
                  backgroundColor: Colors.white,
                ),
              );
          }
          // unreachable
        },
      );
    } else {
      return Container(
        width: 50,
        height: 50,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: MemoryImage(
            cachedFilters[filter.name] as dynamic,
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
