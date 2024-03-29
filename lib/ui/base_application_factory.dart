import 'package:flutter/material.dart';

import 'package:flutterd/ui/mixins/base_application_factory.dart';
import 'package:flutterd/ui/navigation_bar_menu.dart';
import 'package:flutterd/ui/navigation_bar_tabs.dart';
import 'package:flutterd/ui/widgets/base_application.dart';

abstract class BaseApplicationFactory with BaseApplicationFactoryPlatformMixin {
  init();
  BaseNavigationBarMenu constructNavigationBarMenu();
  BaseNavigationBarTabs constructNavigationBarTabs();
  PageRoute constructPageRoute<T>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  });
  StatelessWidget construct(Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates, GlobalKey<NavigatorState>? navigatorKey, RouteFactory? onGenerateRoute, GenerateAppTitle? onGenerateTitle, Map<String, WidgetBuilder> routes,
      {ApplicationFactoryInit? init});
}
