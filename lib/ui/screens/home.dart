import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:flutterd/ui/mixins/platform.dart';

abstract class HomeScreen extends StatelessWidget with PlatformMixin {
  const HomeScreen({Key? key}) : super(key: key);

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.appTitle),
    return FlutterI18n.translate(context, 'appTitle');
  }
}
