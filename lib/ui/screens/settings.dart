import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  String commons(BuildContext context) {
    // AppLocalizations.of(context)!.settings_common
    return FlutterI18n.translate(context, 'settings_common');
  }

  String theme(BuildContext context) {
    // title: AppLocalizations.of(context)!.theme,
    return FlutterI18n.translate(context, 'theme');
  }

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.settings),
    return FlutterI18n.translate(context, 'title_settings');
  }
}
