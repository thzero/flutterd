import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class OpenSourceScreen extends StatefulWidget {
  const OpenSourceScreen({required this.controller, required this.listing, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;
  final List<dynamic> listing;
}

abstract class OpenSourceScreenState<T extends OpenSourceScreen> extends State<T> {
  late WebViewController _webViewController;

  late final String _defaultContent = '<html></html>';

  WebView constructWebView() {
    return WebView(
        initialUrl: null,
        navigationDelegate: (NavigationRequest request) {
          launchUrl(Uri.parse(request.url), mode: LaunchMode.externalApplication);
          return NavigationDecision.prevent;
        },
        onWebViewCreated: (webViewController) async {
          _webViewController = webViewController;
          webViewController.loadHtmlString(_defaultContent);
          widget.controller.complete(webViewController);
          _display();
        });
  }

  _display() {
    final opensourcePackage = FlutterI18n.translate(context, 'opensource_package');
    final opensourceLicense = FlutterI18n.translate(context, 'opensource_license');
    Future.delayed(const Duration(milliseconds: 500), () async {
      String? content = await rootBundle.loadString('assets/html/opensource.html');
      String? contentSnippet = await rootBundle.loadString('assets/html/opensource_snippet.html');

      String output = '';
      List<dynamic> listing = widget.listing;
      String? name;
      String? url;
      for (dynamic item in listing) {
        name = item['name'];
        if (name == null || name.isEmpty) {
          continue;
        }
        url = item['url'];
        if (url == null || url.isEmpty) {
          url = 'https://pub.dev/packages/$name';
        }

        output += sprintf(contentSnippet, [url, name, item['license']]);
      }

      content = sprintf(content, [opensourcePackage, opensourceLicense, output]);

      _webViewController.loadHtmlString(content);
    });
  }

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.title_opensource),
    return FlutterI18n.translate(context, 'title_opensource');
  }
}
