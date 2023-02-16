import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImgResize extends StatefulWidget {
  const ImgResize({super.key});

  @override
  State<ImgResize> createState() => _ImgResizeState();
}

class _ImgResizeState extends State<ImgResize> {
  late final WebViewController controller;
  late String fileText;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            print('onPageStarted : $url');
          },
          onPageFinished: (String url) {
            print('onPageFinished : $url');
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
      );

    loadFile();
    super.initState();
  }

  loadFile() async {
    fileText = await rootBundle.loadString('assets/html/index.html');

    webSetting();
  }

  webSetting() {
    String url = 'https://google.com';

    controller.loadFile(fileText);
  }

  // void _onNavigationDelegateExample(WebViewController controller, BuildContext context) async {
  //   String _fileText = await rootBundle.loadString('assets/html/index.html');
  //   final String contentBase64 = base64Encode(const Utf8Encoder().convert(_fileText));
  //   await controller.loadHtmlString('data:text/html;base64,$contentBase64');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
