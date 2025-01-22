import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:flutterd/app_config.dart';

import 'package:flutterd/models/themes_configuration.dart';
import 'package:flutterd/ui/base_application_factory.dart';
import 'package:flutterd/ui/navigation_bar_tabs.dart';
import 'package:flutterd/ui/navigation_bar_menu.dart';
import 'package:flutterd/ui/widgets/base_application.dart';
import 'package:flutterd/utils/utilities.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//https://stackoverflow.com/questions/62230082/how-to-change-the-applications-language-programmatically-in-flutter

abstract class BaseApplication {
  static final Map<AppTypes, BaseApplicationFactory> map = {};

  init<T extends BaseConfig>(ThemeTypes themes, ConfigConstructionFunc<T> func) async {
    Utilities.config = await AppConfigFactory.forEnvironment<T>(func);

    ThemesConfiguration.init(themes);

    NavigationBarMenu.init(initNavigationBar());
    NavigationBarTabs.init(initNavigationBarTabs());

    Utilities.copyright = initCopyright();
  }

  Widget? initBody() {
    return null;
  }

  Copyright initCopyright();

  BaseNavigationBarMenu initNavigationBar();

  BaseNavigationBarTabs initNavigationBarTabs();

  static AppTypes get appType {
    if (Platform.isIOS || Platform.isMacOS) {
      return AppTypes.cupertino;
    }

    return AppTypes.material;
  }

  static DeviceType get deviceType {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
    return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet; // TODO: dumb, why doesn't Flutter do this automatically?
  }
}
