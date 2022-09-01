import 'package:flutterd/models/shared_preferences.dart';

abstract class RepositoryItem<T> extends Repository {
  T get();
}

abstract class Repository {
  Future<void> load();
  reset();
  Future<void> save(Function update);
}
