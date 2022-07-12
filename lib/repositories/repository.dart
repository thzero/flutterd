abstract class RepositoryItem<T> implements Repository {
  T get();
}

abstract class Repository {
  load();
  reset();
  Future<void> save(Function update);
}
