import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class Article {
  final String title;
  final String url;
  final String urlImage;

  const Article({
    required this.title,
    required this.url,
    required this.urlImage,
  });
}

class Scraping {
  final String urlImage;

  const Scraping({
    required this.urlImage,
  });
}

class Scrap extends StatefulWidget {
  const Scrap({super.key});

  @override
  State<Scrap> createState() => _ScrapState();
}

class _ScrapState extends State<Scrap> {
  ScreenshotController screenshotController = ScreenshotController();
  late final WebViewController controller;
  GlobalKey captureKey = GlobalKey();

  late String generatedPdfFilePath;

  List<Article> articles = [];
  List<Scraping> scraping = [];

  List images = [];

  String? responsebody;

  String url = 'https://google.com';
  // String finishUrl = '';

  File? file;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
          },
          onPageStarted: (String url) {
            print('onPageStarted : $url');
          },
          onPageFinished: (String url) {
            print('onPageFinished : $url');
            makeRequest(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('error : ${error.errorCode}');
            controller.goBack();
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    // #enddocregion webview_controller
  }

  void makeRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    print('statusCode : ${response.statusCode}');

    if (response.statusCode == 200) {
      responsebody = response.body;
    } else {
      print('else statusCode : ${response.statusCode}');
    }
  }

  Future getWebsiteData(dynamic body) async {
    dom.Document html = dom.Document.html('''
      <html>
        $body
      </html>
    ''');

    html //
        .querySelectorAll('img')
        .map((e) {
      if (e.attributes['src'] != null) {
        if (!e.attributes['src'].toString().contains('favicon') &&
            !e.attributes['src'].toString().contains('svg') &&
            e.attributes['src'].toString().contains('https://')) {
          if (!images.contains(e.attributes['src'])) {
            images.add(e.attributes['src']);
          }
        }
      }

      if (e.attributes['data-src'] != null) {
        if (!e.attributes['data-src'].toString().contains('favicon') &&
            !e.attributes['data-src'].toString().contains('svg') &&
            e.attributes['data-src'].toString().contains('https://')) {
          if (!images.contains(e.attributes['data-src'])) {
            images.add(e.attributes['data-src']);
          }
        }
      }
    }).toList();

    print(images.length);
    // log(images.toString());

    for (var i in images) {
      print(i);
    }

    setState(() {
      scraping = List.generate(images.length, (index) => Scraping(urlImage: images[index]));
      images = [];
    });
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.1),
            height: 48,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.goBack();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                    )),
                IconButton(
                    onPressed: () {
                      controller.goForward();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )),
                Expanded(child: Container()),
                TextButton(
                    onPressed: () async {
                      print('capture');
                      String docu = await controller.runJavaScriptReturningResult('document.body.innerHTML') as String;
                      getWebsiteData(docu);
                    },
                    child: const Text('Capture')),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(
                  controller: controller,
                  layoutDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          Visibility(
              visible: scraping.isEmpty ? false : true,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10.0,
                      offset: const Offset(0, -10), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: scraping.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            scraping[index].urlImage,
                            errorBuilder: (context, error, stackTrace) {
                              return Container();
                            },
                          )),
                    );
                  },
                ),
              ))
        ],
      )),
    );
  }
}
