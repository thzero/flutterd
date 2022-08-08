import 'package:flutter/widgets.dart';

import 'package:fluttered/ui/navigator_settings.dart';

abstract class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic>? pushNamed(String routeName) {
    return NavigatorService.navigatorKey.currentState?.pushNamed(routeName);
  }

  static Future<dynamic>? pushNamedByIdentifier(String routeName, String identifier) {
    return NavigatorService.navigatorKey.currentState?.pushNamed(routeName, arguments: IdentifierNavigationSettings(identifier));
  }

  static void pop() {
    return NavigatorService.navigatorKey.currentState?.pop();
  }
}
