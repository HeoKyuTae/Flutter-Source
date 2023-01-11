import 'dart:developer';

import 'package:flutter/material.dart';
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
  late final WebViewController controller;
  List<Article> articles = [];
  List<Scraping> scraping = [];

  List images = [];

  String? responsebody;

  String url = 'https://google.com';
  // String finishUrl = '';

  @override
  void initState() {
    super.initState();

    // getWebsiteData();

    // finishUrl = url;

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
            print('error : $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    // #enddocregion webview_controller
  }

  void makeRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if (response.statusCode == 200) {
      responsebody = response.body;
      // String htmlToParse = response.body;
      // log(htmlToParse);
    } else {
      print(response.statusCode);
    }
  }

  Future getWebsiteData(dynamic body) async {
    // final url = Uri.parse('https://www.amazon.com/s?k=iphone');
    // final response = await http.get(url);
    dom.Document html = dom.Document.html('''
<html>
$body
</html>
''');
/*
    final titles = html //
        .querySelectorAll('h2 > a > span')
        .map((e) => e.innerHtml.trim())
        .toList();

    final urls = html //
        .querySelectorAll('h2 > a')
        .map((e) => 'https://www.amazon.com/${e.attributes['href']}')
        .toList();

    final urlImages = html //
        .querySelectorAll('span > a > div > img')
        .map((e) => e.attributes['src']!)
        .toList();
*/

    final urlImages = html //
        .querySelectorAll('img')
        .map((e) {
      // => e.attributes['data-src']
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
    log(images.toString());

    setState(() {
      scraping = List.generate(images.length, (index) => Scraping(urlImage: images[index]));
      images = [];
    });
    // setState(() {
    //   articles = List.generate(
    //       titles.length, (index) => Article(title: titles[index], url: urls[index], urlImage: urlImages[index]));
    // });
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
                      // log(docu);
                      getWebsiteData(docu);
                      // if (responsebody != null) {
                      //   getWebsiteData(responsebody);
                      // }
                    },
                    child: const Text('Capture')),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(child: WebViewWidget(controller: controller)),
          scraping.isEmpty
              ? Container()
              : Container(
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
                            // child: Image.network(articles[index].urlImage),
                            child: Image.network(
                              scraping[index].urlImage,
                              errorBuilder: (context, error, stackTrace) {
                                return Container();
                              },
                            )),
                      );
                    },
                  ),
                )
        ],
      )),
    );
  }
}


// Container(
          //   height: 100,
          //   color: Colors.grey.withOpacity(0.5),
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: articles.length,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: Container(
          //           width: 100,
          //           height: 100,
          //           child: Image.network(articles[index].urlImage),
          //         ),
          //       );
          //     },
          //   ),
          // )