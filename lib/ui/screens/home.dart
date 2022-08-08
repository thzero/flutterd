import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:fluttered/ui/mixins/platform.dart';
import 'package:fluttered/ui/navigation_bar_menu.dart';

abstract class HomeScreen extends StatelessWidget with PlatformMixin {
  const HomeScreen({Key? key}) : super(key: key);

  selected(context, NavigationBarMenuItem value) {
    Navigator.pushNamed(context, value.route);
  }

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.appTitle),
    return FlutterI18n.translate(context, 'appTitle');
  }
}
