import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:fluttered/ui/screens/help.dart';
import 'package:fluttered/ui/screens/home.dart';
import 'package:fluttered/ui/screens/material/home.dart';
import 'package:fluttered/ui/screens/material/help.dart';
import 'package:fluttered/ui/screens/material/opensource.dart';
import 'package:fluttered/ui/screens/opensource.dart';
import 'package:fluttered/ui/mixins/base_application_factory.dart';

mixin MaterialApplicationFactoryPlatformMixin on BaseApplicationFactoryPlatformMixin {
  @override
  HelpScreen constructHelpScreen(Completer<WebViewController> controller) {
    return MaterialHelpScreen(controller);
  }

  @override
  HomeScreen constructHomeScreen() {
    return const MaterialHomeScreen();
  }

  @override
  OpenSourceScreen constructOpenSourceScreen(List<dynamic> listing, Completer<WebViewController> controller) {
    return MaterialOpenSourceScreen(listing, controller);
  }
}
