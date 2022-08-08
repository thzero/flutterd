import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutterd/models/shared_preferences.dart';
import 'package:flutterd/models/themes_configuration.dart';

class ThemeState {
  final int theme;
  final ThemeData? darkThemeData;
  final ThemeData? themeData;

  ThemeState(this.darkThemeData, this.themeData, this.theme);
  ThemeState.init()
      : darkThemeData = null,
        themeData = null,
        theme = 0;

  @override
  List<Object> get props => [theme];

  ThemeState copyWith({int? theme}) {
    ThemeState state = ThemeState(darkThemeData, themeData, theme ?? this.theme);
    return state;
  }

  static ThemeState fromPreferences(SharedPreferencesModel preferences) {
    return ThemeState(null, null, preferences.theme ?? 0);
  }

  String themeAsString(context) {
    ThemeTypeInfo? themeV = ThemesConfiguration.themes[theme];
    if (themeV == null) {
      return FlutterI18n.translate(context, 'theme_unknown');
    }

    return FlutterI18n.translate(context, 'theme_${themeV.name}');
  }

  SharedPreferencesModel toPreferences(SharedPreferencesModel preferences) {
    preferences.theme = theme;
    return preferences;
  }
}
