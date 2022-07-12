import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:thzero_library/ui/screens/help.dart';
import 'package:thzero_library/ui/screens/home.dart';
import 'package:thzero_library/ui/screens/material/home.dart';
import 'package:thzero_library/ui/screens/material/help.dart';
import 'package:thzero_library/ui/screens/material/opensource.dart';
import 'package:thzero_library/ui/screens/material/settings/settings.dart';
import 'package:thzero_library/ui/screens/opensource.dart';
import 'package:thzero_library/ui/screens/settings.dart';
import 'package:thzero_library/ui/mixins/base_application_factory.dart';

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

  @override
  SettingsScreen constructSettingsScreen() {
    return const MaterialSettingsScreen();
  }
}
