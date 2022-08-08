import 'package:flutter/widgets.dart';

import 'package:flutterd/ui/mixins/platform.dart';

abstract class BaseNavigationTabSelectorWidget extends StatelessWidget with PlatformMixin {
  final int activeTab;
  final Function(int) onTabSelected;

  const BaseNavigationTabSelectorWidget(
    this.activeTab,
    this.onTabSelected, {
    Key? key,
  }) : super(key: key);
}
