import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late WebViewController webViewController;
  double webViewProgress = 0;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await webViewController.canGoBack()){
          webViewController.goBack();
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aymakan-drivers'),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (await webViewController.canGoBack()) {
                  webViewController.goBack();
                }
              },
            ),
            IconButton(
              onPressed: () => webViewController.reload(),
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Column(
          children: [
            webViewProgress < 1 ? SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                value: webViewProgress,
                color: Colors.red,
                backgroundColor: Colors.black,
              ),
            ) : SizedBox(),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://dev-click.aymakan.com.sa',
                onWebViewCreated: (controller) {
                  this.webViewController = controller;
                },
                onPageStarted: (url) {
                  print('New url: $url');
                },
                onProgress: (progress) => setState(() => this.webViewProgress = progress / 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
