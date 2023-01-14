import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutterd/ui/screens/opensource.dart';

class MaterialOpenSourceScreen extends OpenSourceScreen {
  const MaterialOpenSourceScreen(List<dynamic> listing, Completer<WebViewController> controller, {Key? key}) : super(controller: controller, listing: listing, key: key);

  @override
  State<MaterialOpenSourceScreen> createState() => _MaterialOpenSourceScreenState();
}

class _MaterialOpenSourceScreenState extends OpenSourceScreenState<MaterialOpenSourceScreen> {
  @override
  void initState() {
    super.initState();

    // if (Platform.isAndroid) {
    //   WebView.platform = AndroidWebView();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title(context)),
        ),
        body: constructWebView());
  }
}
