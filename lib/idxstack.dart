import 'dart:io';

import 'package:flutter/material.dart';
import 'package:make_source/idxStackBox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class IdxStack extends StatefulWidget {
  const IdxStack({super.key});

  @override
  State<IdxStack> createState() => _IdxStackState();
}

class _IdxStackState extends State<IdxStack> {
  late ScreenshotController screenshotController;
  List<ScreenshotController> controllers = [];
  List<Widget> list = [];
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.black,
  ];
  int isSelect = 0;
  File? file;
  int sum = 0;

  @override
  void initState() {
    for (var i = 0; i < 3; i++) {
      screenshotController = ScreenshotController();
      if (controllers.contains(screenshotController)) {
        print('same');
      } else {
        print('insert');
        controllers.add(screenshotController);
        list.add(IdxStackBox(color: colors[i], screenshotController: screenshotController));
      }
    }

    print(controllers.length);
    print(controllers);
    super.initState();
  }

  void shot(int i) {
    controllers[i].capture(delay: const Duration(milliseconds: 10)).then(
      (capturedImage) async {
        print(capturedImage);

        final rootDir = await getTemporaryDirectory();
        var dir = '${rootDir.path}/image';
        print(dir);

        dir = '$dir/screenshot';

        final directory = Directory(dir);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        if (capturedImage != null) {
          file = await File('$dir/shot${DateTime.now().toString()}.png').writeAsBytes(capturedImage, flush: true);
        }

        setState(() {
          sum++;
        });
      },
    ).catchError(
      (onError) {
        print(onError);
      },
    );

    /*
    for (var i = 0; i < controllers.length; i++) {
      var control = controllers[i];
      control.capture(delay: const Duration(milliseconds: 10)).then(
        (capturedImage) async {
          print(capturedImage);

          final rootDir = await getTemporaryDirectory();
          var dir = '${rootDir.path}/image';
          print(dir);

          dir = '$dir/screenshot';

          final directory = Directory(dir);
          if (!directory.existsSync()) {
            directory.createSync(recursive: true);
          }

          if (capturedImage != null) {
            file = await File('$dir/shot${DateTime.now().toString()}.png').writeAsBytes(capturedImage, flush: true);
          }

          setState(() {});
        },
      ).catchError(
        (onError) {
          print(onError);
        },
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: Column(
            children: [
              IndexedStack(index: isSelect, children: list),
              ElevatedButton(
                  onPressed: () {
                    print('object');
                    setState(() {
                      isSelect = 0;
                    });
                  },
                  child: const Text('1')),
              ElevatedButton(
                  onPressed: () {
                    print('object');
                    setState(() {
                      isSelect = 1;
                    });
                  },
                  child: const Text('2')),
              ElevatedButton(
                  onPressed: () {
                    print('object');
                    setState(() {
                      isSelect = 2;
                    });
                  },
                  child: const Text('3')),
              ElevatedButton(
                  onPressed: () {
                    print('shot');
                    shot(sum);
                  },
                  child: const Text('ScreenShot')),
              file == null ? Container() : Image.file(file!)
            ],
          ),
        ),
      ),
    );
  }
}
