import 'dart:io';

import 'package:flutter/material.dart';
import 'package:make_source/photo/album.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image/image.dart' as img;

class Photo extends StatefulWidget {
  const Photo({super.key});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  List<AssetPathEntity>? _paths;
  List<Album> _albums = [];
  late List<AssetEntity> _images;
  int _currentPage = 0;
  late Album _currentAlbum;
  AssetEntity? entity;
  File? original;

  Future<String> getImageDirectory({String subDirectory = ''}) async {
    final rootDir = await getTemporaryDirectory();
    var dir = '${rootDir.path}/original';
    if (subDirectory.isNotEmpty) {
      dir = '$dir/$subDirectory';
    }

    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return dir;
  }

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> getAlbum() async {
    _paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    _albums = _paths!.map((e) {
      return Album(
        id: e.id,
        name: e.isAll ? '모든 사진' : e.name,
      );
    }).toList();

    await getPhotos(_albums[0], albumChange: true);
  }

  Future<void> getPhotos(
    Album album, {
    bool albumChange = false,
  }) async {
    _currentAlbum = album;
    albumChange ? _currentPage = 0 : _currentPage++;

    final loadImages = await _paths!.singleWhere((element) => element.id == album.id).getAssetListPaged(
          page: _currentPage,
          size: 20,
        );

    setState(() {
      if (albumChange) {
        _images = loadImages;
      } else {
        _images.addAll(loadImages);
      }
    });
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
    original = File('$dir/resize_${DateTime.now().millisecondsSinceEpoch}.png')
      ..writeAsBytesSync(img.encodeJpg(thumbnail, quality: 20), flush: true);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  info() async {
    final String? mediaUrl = await entity!.getMediaUrl();
    final File? imageFile = await entity!.file;
    final File? videoFile = await entity!.fileWithSubtype;
    final File? originImageFile = await entity!.originFile;
    final File? originVideoFile = await entity!.originFileWithSubtype;

    setState(() {
      original = imageFile;
    });

    print("mediaUrl : $mediaUrl");
    print("imageFile : $imageFile");
    print("videoFile : $videoFile");
    print("originImageFile : $originImageFile");
    print("originVideoFile : $originVideoFile");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: _albums.isNotEmpty
                ? DropdownButton(
                    value: _currentAlbum,
                    items: _albums
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        getPhotos(value, albumChange: true);
                      }
                    },
                  )
                : const SizedBox()),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: original != null ? Image.file(original!) : const SizedBox.shrink(),
            // child: entity != null
            //     ? AssetEntityImage(
            //         entity!,
            //         isOriginal: true,
            //         fit: BoxFit.cover,
            //         thumbnailFormat: ThumbnailFormat.jpeg,
            //         repeat: ImageRepeat.noRepeat,
            //       )
            //     : const SizedBox.shrink(),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                final scrollPixels = scroll.metrics.pixels / scroll.metrics.maxScrollExtent;

                print('scrollPixels = $scrollPixels');
                if (scrollPixels > 0.7) getPhotos(_currentAlbum);

                return false;
              },
              child: SafeArea(
                  child: _paths == null
                      ? const Center(child: CircularProgressIndicator())
                      : GridView(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          children: _images.map((e) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  entity = e;
                                  info();
                                });
                              },
                              child: AssetEntityImage(
                                e,
                                isOriginal: false,
                                fit: BoxFit.cover,
                                thumbnailFormat: ThumbnailFormat.jpeg,
                              ),
                            );
                          }).toList(),
                        ) //GridPhoto(images: _images),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
