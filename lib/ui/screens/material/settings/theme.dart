import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import 'package:flutterd/blocs/theme/events/theme.dart';
import 'package:flutterd/blocs/theme/theme_bloc.dart';
import 'package:flutterd/blocs/theme/theme_state.dart';
import 'package:flutterd/models/themes_configuration.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialThemeSettingsScreen extends StatelessWidget {
  const MaterialThemeSettingsScreen({Key? key}) : super(key: key);

  static final List<SettingsSection> _sectionsAdditional = [];

  static addSection(SettingsSection section) {
    _sectionsAdditional.add(section);
  }

  List<SettingsSection> _sections(BuildContext context, ThemeState state) {
    // SettingsSection(title: AppLocalizations.of(context)!.theme, tiles: _tilesThemes(context, state))
    List<SettingsSection> output = [];
    output.add(SettingsSection(title: FlutterI18n.translate(context, 'title_theme'), tiles: _tilesThemes(context, state)));
    output.addAll(_sectionsAdditional);
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(AppLocalizations.of(context)!.themes)),
        appBar: AppBar(title: Text(FlutterI18n.translate(context, 'title_themes'))),
        body: BlocBuilder<ThemeBloc, ThemeState>(
          buildWhen: (previousState, state) {
            return true;
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(top: 5),
              child: SettingsList(sections: _sections(context, state)),
            );
          },
        ));
  }

  void _changeTheme(context, int theme) {
    ThemeBloc bloc = BlocProvider.of<ThemeBloc>(context);
    bloc.add(ThemeChangeEvent(theme));
  }

  List<SettingsTile> _tilesThemes(BuildContext context, ThemeState state) {
    final List<SettingsTile> list = [];
    ThemesConfiguration.themes.forEach((key, value) {
      list.add(SettingsTile(
        // title: AppLocalizations.of(context)!.theme_blue,
        title: FlutterI18n.translate(context, 'theme_${value.name}'),
        trailing: _trailingWidget(state, key),
        onPressed: (BuildContext context) {
          _changeTheme(context, key);
        },
      ));
    });
    return list;
  }

  Widget _trailingWidget(ThemeState state, int theme) {
    return (state.theme == theme) ? const Icon(Icons.check, color: Colors.blue) : const Icon(null);
  }
}
