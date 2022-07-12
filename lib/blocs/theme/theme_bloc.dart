import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging_wrapper/logging.dart';

import 'package:thzero_library/blocs/theme/events/load.dart';
import 'package:thzero_library/blocs/theme/mediator.dart';
import 'package:thzero_library/blocs/theme/events/theme.dart';
import 'package:thzero_library/blocs/theme/theme_state.dart';
import 'package:thzero_library/models/shared_preferences.dart';
import 'package:thzero_library/models/themes_configuration.dart';
import 'package:thzero_library/repositories/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferencesRepository _repository;
  ThemeBloc(this._repository)
      : super(
          ThemeState(ThemesConfiguration.darkTheme(0), ThemesConfiguration.theme(0), 0),
        ) {
    on<ThemeChangeEvent>(_handleTheme);
    on<LoadThemeEvent>(_handleLoad);

    _load(_repository.get());
  }

  @override
  void onChange(Change<ThemeState> change) {
    super.onChange(change);

    if (change.nextState.theme != change.currentState.theme) {
      _repository.save((preferences) {
        return change.nextState.toPreferences(preferences);
      });
    }
  }

  FutureOr<void> _handleLoad(LoadThemeEvent event, Emitter<ThemeState> emit) {
    emit(event.state);
  }

  FutureOr<void> _handleTheme(ThemeChangeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(ThemesConfiguration.darkTheme(event.theme), ThemesConfiguration.theme(event.theme), event.theme));
    ThemeMediator().themeUpdated.add(ThemeChangeEvent(event.theme));
  }

  _load(SharedPreferencesModel? preferences) {
    Logger().dV('ThemeBloc', '_load', 'preferences', preferences);
    if (preferences == null) {
      return;
    }

    ThemeState state = ThemeState.fromPreferences(preferences);
    add(ThemeChangeEvent(state.theme));
  }
}

class LoadSettingsEvent {}
