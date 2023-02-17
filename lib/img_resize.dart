import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/util.dart';
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
      )
      ..addJavaScriptChannel(
        'alert',
        onMessageReceived: (JavaScriptMessage message) {
          print(message.message);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
        },
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );
    // ..loadRequest(Uri.parse('https://flutter.dev'));

    loadFile();
    super.initState();
  }

  loadFile() async {
    fileText = await rootBundle.loadString('assets/html/index.html');

    webSetting();
  }

  webSetting() {
    String url = 'https://google.com';

    // controller.loadFile(fileText);

    controller.loadHtmlString(fileText);
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return controller.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    return controller.runJavaScript(
      'alert.postMessage("message("hello")");',
    );

    // await controller.runJavaScript('Toaster.postMessage(hello("Hello World"))');
    // final String cookies = await controller.runJavaScriptReturningResult('document.title') as String;
    // print(cookies);
  }

  Future<void> _onShowHello() {
    return controller.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              WebViewWidget(
                controller: controller,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: ElevatedButton(
                    onPressed: () {
                      _onListCookies(context);
                    },
                    child: Text('press')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
