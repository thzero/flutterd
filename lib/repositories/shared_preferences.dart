import 'dart:convert';

import 'package:mutex/mutex.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thzero_library/models/shared_preferences.dart';
import 'package:thzero_library/repositories/repository.dart';

abstract class SharedPreferencesRepository<T extends SharedPreferencesModel> implements RepositoryItem<T> {
  // Key is used to access store
  static const String _sharedPrefKey = 'app_preferences_storage';

  late T preferences;

  static final Mutex _mutex = Mutex();

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  SharedPreferencesRepository.internal() {
    // initialization logic
    preferences = getInstance();
  }

  @override
  T get() {
    return preferences;
  }

  T getInstance();

  T fromJson(dynamic decoded);

  @override
  load() async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(_sharedPrefKey);

    if (json == null || json.isEmpty) {
      return null;
    }

    preferences = fromJson(jsonDecode(json));
  }

  @override
  reset() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(_sharedPrefKey);
  }

  @override
  Future<void> save(Function update) async {
    await _mutex.protect(() async {
      SharedPreferencesModel? preferences2 = update(preferences);
      if (preferences2 == null) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      String json = jsonEncode(preferences2.toJson());
      prefs.setString(_sharedPrefKey, json);
    });
  }
}
