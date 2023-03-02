import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

class InappScrap extends StatefulWidget {
  const InappScrap({super.key});

  @override
  State<InappScrap> createState() => _InappScrapState();
}

class _InappScrapState extends State<InappScrap> {
  InAppWebViewController? webViewController;

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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse('https://flutter.dev')),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              ),
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                  onPressed: () async {
                    print('object');
                    var screenshotBytes = await webViewController!.takeScreenshot();
                    print(screenshotBytes);

                    final dir = await getImageDirectory(subDirectory: 'square');
                    print(dir);

                    if (screenshotBytes != null) {
                      await File('$dir/square.png').writeAsBytes(screenshotBytes, flush: true);
                    }
                  },
                  child: const Text('ScreenShot')),
            )
          ],
        ),
      ),
    );
  }
}
