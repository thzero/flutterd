import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:webview_flutter/webview_flutter.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class HelpScreen extends StatefulWidget {
  const HelpScreen({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;
}

abstract class HelpScreenState<T extends HelpScreen> extends State<T> {
  final WebViewController _controller = WebViewController()..loadFlutterAsset('assets/html/help/index.html');

  StatelessWidget constructWebView() {
    return WebViewWidget(controller: _controller);
    // WebView(
    //     initialUrl: null,
    //     onWebViewCreated: (webViewController) {
    //       webViewController.loadFlutterAsset('assets/html/help/index.html');
    //       widget.controller.complete(webViewController);
    //     });
  }

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.title_help),
    return FlutterI18n.translate(context, 'title_help');
  }
}
