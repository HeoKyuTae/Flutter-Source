import 'package:flutter/material.dart';
import 'package:make_source/photo/album.dart';
import 'package:make_source/photo/grid_photo.dart';
import 'package:photo_manager/photo_manager.dart';

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

  @override
  void initState() {
    super.initState();
    checkPermission();
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          final scrollPixels = scroll.metrics.pixels / scroll.metrics.maxScrollExtent;

          print('scrollPixels = $scrollPixels');
          if (scrollPixels > 0.7) getPhotos(_currentAlbum);

          return false;
        },
        child: SafeArea(
          child: _paths == null ? const Center(child: CircularProgressIndicator()) : GridPhoto(images: _images),
        ),
      ),
    );
  }
}
