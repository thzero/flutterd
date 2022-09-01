import 'dart:convert';

import 'package:mutex/mutex.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterd/models/shared_preferences.dart';
import 'package:flutterd/repositories/repository.dart';

abstract class SharedPreferencesRepository<T extends SharedPreferencesModel> extends RepositoryItem<T> {
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
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(_sharedPrefKey);

    if (json == null || json.isEmpty) {
      return;
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
    // await _mutex.protect(() async {
    SharedPreferencesModel? preferences2 = update(preferences);
    if (preferences2 == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    String json = jsonEncode(preferences2.toJson());
    prefs.setString(_sharedPrefKey, json);
    // });
  }
}

class RepositoryLoadVersionCheckResults {
  final bool results;
  final double version;
  RepositoryLoadVersionCheckResults(this.results, this.version);
}

typedef LoadByVersionLoad<T extends SharedPreferencesModel> = double? Function(T preferences);

typedef LoadByVersionUpdate<T extends SharedPreferencesModel> = T Function(T preferences, double version);

abstract class RepositoryVersioned<T extends SharedPreferencesRepository, U extends SharedPreferencesModel> extends Repository {
  Future<bool> loadByVersion(
    Map<String, dynamic> data,
    T repository,
    LoadByVersionLoad<U> loadFunc,
    LoadByVersionUpdate<U> updateFunc,
  ) async {
    RepositoryLoadVersionCheckResults updateRequired = requiresUpdateByVersion2(loadFunc(repository.preferences as U), data);
    if (!updateRequired.results) {
      return false;
    }

    bool valid = false;
    try {
      await loadByVersionI(dataFromSource(data));
      valid = true;
    } catch (ex) {
      valid = false;
    }

    if (valid) {
      await repository.save((preferences) {
        var preferences2 = updateFunc(preferences, updateRequired.version);
        return preferences2;
      });
    }

    return true;
  }

  Future<void> loadByVersionI(
    Map<String, dynamic> data,
  ) async {}

  RepositoryLoadVersionCheckResults requiresUpdateByVersion(double? versionCurrent, double? versionSource) {
    if (versionSource == null) {
      throw Exception("No source version.");
    }
    double version = versionCurrent ?? 0;
    return RepositoryLoadVersionCheckResults(version < versionSource, versionSource);
  }

  RepositoryLoadVersionCheckResults requiresUpdateByVersion2(double? versionCurrent, Map<String, dynamic> source) {
    double? versionSource = source['version'] as double?;
    return requiresUpdateByVersion(versionCurrent, versionSource);
  }

  Map<String, dynamic> dataFromSource(Map<String, dynamic> source) {
    return source['data'];
  }

  // Future<void> updateLoadVersion(double version) async {
  //   await AppSharedPreferencesRepository().save((preferences) {
  //     preferences.versionDataInsurance = version;
  //     return preferences;
  //   });
  // }
}
