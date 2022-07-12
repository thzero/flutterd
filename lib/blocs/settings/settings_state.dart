// import 'package:equatable/equatable.dart';

// import 'package:flutter_i18n/flutter_i18n.dart';

// import 'package:thzero_library/models/themes_configuration.dart';
// import 'package:thzero_library/models/shared_preferences.dart';

// class SettingsState extends Equatable {
//   final int theme;

//   const SettingsState(this.theme);

//   const SettingsState.init() : theme = 0;

//   @override
//   List<Object> get props => [theme];

//   SettingsState copyWith({int? theme}) {
//     SettingsState state = SettingsState(theme ?? this.theme);
//     return state;
//   }

//   static SettingsState fromPreferences(SharedPreferencesModel preferences) {
//     return SettingsState(preferences.theme ?? 0);
//   }

//   String themeAsString(context) {
//     ThemeTypeInfo? themeV = ThemesConfiguration.themes[theme];
//     if (themeV == null) {
//       return FlutterI18n.translate(context, 'theme_unknown');
//     }

//     return FlutterI18n.translate(context, 'theme_${themeV.name}');
//     // if (theme.toString() == AppTheme.blue) {
//     //   return AppLocalizations.of(context)!.theme_blue;
//     // }
//     // if (theme == AppTheme.red) {
//     //   return AppLocalizations.of(context)!.theme_red;
//     // }
//     // return '';
//   }

//   SharedPreferencesModel toPreferences(SharedPreferencesModel preferences) {
//     preferences.theme = theme;
//     return preferences;
//   }
// }
