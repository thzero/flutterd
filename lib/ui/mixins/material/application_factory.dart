import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutterd/ui/mixins/base_application_factory.dart';
import 'package:flutterd/ui/screens/about.dart';
import 'package:flutterd/ui/screens/help.dart';
import 'package:flutterd/ui/screens/home.dart';
import 'package:flutterd/ui/screens/opensource.dart';
import 'package:flutterd/ui/screens/material/about.dart';
import 'package:flutterd/ui/screens/material/home.dart';
import 'package:flutterd/ui/screens/material/help.dart';
import 'package:flutterd/ui/screens/material/opensource.dart';

mixin MaterialApplicationFactoryPlatformMixin on BaseApplicationFactoryPlatformMixin {
  @override
  AboutScreen constructAboutScreen() {
    return const MaterialAboutScreen();
  }

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
