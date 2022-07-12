import 'package:flutter/widgets.dart';

class NavigationBarTabs {
  static late BaseNavigationBarTabs tabs;

  static init(BaseNavigationBarTabs menuList) {
    NavigationBarTabs.tabs = menuList;
  }

  static Key key() {
    return tabs.key();
  }

  static Iterable<int> values() {
    return tabs.values();
  }

  static Widget determineTabBody(int tab) {
    return tabs.determineTabBody(tab);
  }

  static Icon determineTabIcon(int tab) {
    return tabs.determineTabIcon(tab);
  }

  static String determineTabLabel(BuildContext context, int tab) {
    return tabs.determineTabLabel(context, tab);
  }
}

abstract class BaseNavigationBarTabs {
  Widget determineTabBody(int tab);
  Icon determineTabIcon(int tab);
  String determineTabLabel(BuildContext context, int tab);
  Key key();
  Iterable<int> values();
}
