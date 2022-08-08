import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:fluttered/ui/screens/help.dart';

class MaterialHelpScreen extends HelpScreen {
  const MaterialHelpScreen(Completer<WebViewController> controller, {Key? key}) : super(controller: controller, key: key);

  @override
  State<MaterialHelpScreen> createState() => _MaterialHelpScreenState();
}

class _MaterialHelpScreenState extends HelpScreenState<MaterialHelpScreen> {
  @override
  void initState() {
    super.initState();
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
