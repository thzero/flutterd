// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:logging_wrapper/logging.dart';

// import 'package:thzero_library/blocs/theme/mediator.dart';
// import 'package:thzero_library/blocs/settings/events/load.dart';
// import 'package:thzero_library/blocs/settings/events/settings.dart';
// import 'package:thzero_library/blocs/settings/events/theme.dart';
// import 'package:thzero_library/blocs/settings/settings_state.dart';
// import 'package:thzero_library/blocs/theme/events/theme.dart';
// import 'package:thzero_library/models/shared_preferences.dart';
// import 'package:thzero_library/repositories/shared_preferences.dart';

// abstract class SettingsBloc<T extends SettingsState> extends Bloc<SettingsEvent, T> {
//   final SharedPreferencesRepository _repository;

//   SettingsBloc(this._repository, T state) : super(state) {
//     on<LoadSettingsEvent>(_handleLoad);
//     on<ThemeSettingsEvent>(_handleTheme);

//     _load(_repository.get());
//   }

//   @override
//   void onChange(Change<T> change) {
//     super.onChange(change);

//     if (change.nextState != change.currentState) {
//       _repository.save((preferences) {
//         return change.nextState.toPreferences(preferences);
//       });
//     }
//   }

//   FutureOr<void> _handleLoad(LoadSettingsEvent event, Emitter<T> emit) {
//     emit(event.state);

//     // stream.listen((state) async {
//     //   await _repository.save(state);
//     // });
//     ThemeMediator().themeUpdated.add(ThemeEvent(event.state.theme));
//   }

//   FutureOr<void> _handleTheme(ThemeSettingsEvent event, Emitter<T> emit) {
//     emit(state.copyWith(theme: event.theme));
//     ThemeMediator().themeUpdated.add(ThemeEvent(event.theme));
//   }

//   _load(SharedPreferencesModel? preferences) {
//     Logger().dV('SettingsBloc', '_load', 'preferences', preferences);
//     if (preferences == null) {
//       return;
//     }

//     // SettingsState state = SettingsState.fromPreferences(preferences);
//     // add(LoadSettingsEvent(state: state));
//   }
// }
