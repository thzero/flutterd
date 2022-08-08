import 'package:flutter/material.dart';

import 'package:flutterd/ui/mixins/material/platform.dart';
import 'package:flutterd/ui/navigation_bar_tabs.dart';
import 'package:flutterd/ui/widgets/base_navigation_tab_selector.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialNavigationTabSelectorWidget extends BaseNavigationTabSelectorWidget with MaterialPlatformMixin {
  const MaterialNavigationTabSelectorWidget(
    int activeTab,
    Function(int) onTabSelected, {
    Key? key,
  }) : super(activeTab, onTabSelected, key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: NavigationBarTabs.key(),
      currentIndex: activeTab,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) => onTabSelected(index),
      items: NavigationBarTabs.values().map((tab) {
        return BottomNavigationBarItem(
          icon: NavigationBarTabs.determineTabIcon(tab),
          label: NavigationBarTabs.determineTabLabel(context, tab),
        );
      }).toList(),
    );
  }
}
