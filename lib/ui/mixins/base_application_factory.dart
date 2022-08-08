import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutterd/ui/screens/help.dart';
import 'package:flutterd/ui/screens/home.dart';
import 'package:flutterd/ui/screens/opensource.dart';
import 'package:flutterd/ui/screens/settings.dart';

mixin BaseApplicationFactoryPlatformMixin {
  HelpScreen constructHelpScreen(Completer<WebViewController> controller);
  HomeScreen constructHomeScreen();
  OpenSourceScreen constructOpenSourceScreen(List<dynamic> listing, Completer<WebViewController> controller);
  SettingsScreen constructSettingsScreen();
}
