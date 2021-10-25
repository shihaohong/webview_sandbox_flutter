import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const String baseUrl = 'https://api.rawg.io/api';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            '$baseUrl/games?page=1&page_size=20&platforms=187&dates=2020-10-03,2021-10-03&ordering=released&key=02ef6ba5d13444ee86bad607e8bce3f4',
          ),
        ),
        onLoadStop: (InAppWebViewController controller, Uri? url) async {
          url = url!;
          print('loading finished');
          print('url: $url');
          print('url: ${url.path}');
          if (url.path.contains('games')) {
            var html = await controller.evaluateJavascript(
              source:
                  "window.document.getElementsByTagName('html')[0].innerText;",
            ) as String;

            print('html: $html');
            print(json.decode(html));
          }
        },
      ),
    );
  }
}
