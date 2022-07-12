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

  add(String title, IconData? icon, String route) {
    menuList.add(NavigationBarMenuItem(title, icon, route));
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

  const NavigationBarMenuItem(this.title, this.icon, this.route);
}
