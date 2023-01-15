import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

class NavigationBarMenu {
  static late BaseNavigationBarMenu menuList;

  static init(BaseNavigationBarMenu menuList) {
    NavigationBarMenu.menuList = menuList;
    menuList.init();
  }

  static String title(BuildContext context, String tag) {
    return menuList.title(context, tag);
  }
}

abstract class BaseNavigationBarMenu {
  final List<NavigationBarMenuItem> menuList = [];
  init();

  add(String title, IconData? icon, String route, {bool isLink = false}) {
    menuList.add(NavigationBarMenuItem(title, icon, route, isLink));
  }

  String title(BuildContext context, String tag);
  String translate(BuildContext context, String tag) {
    return FlutterI18n.translate(context, tag);
  }
}

class NavigationBarMenuItem {
  final String title;
  final IconData? icon;
  final String route;
  final bool isLink;

  const NavigationBarMenuItem(this.title, this.icon, this.route, this.isLink);
}
