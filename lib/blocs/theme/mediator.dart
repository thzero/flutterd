import 'dart:async';

import 'package:flutterd/blocs/theme/events/theme.dart';

class ThemeMediator {
  static final StreamController<ThemeChangeEvent> _themeUpdate = StreamController<ThemeChangeEvent>();

  static final ThemeMediator _instance = ThemeMediator._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory ThemeMediator() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  ThemeMediator._internal() {
    // initialization logic
  }

  StreamController<ThemeChangeEvent> get themeUpdated {
    return _themeUpdate;
  }
}
