abstract class Model {
  Model();
  Model.init();

  // TODO: ObjectBox does not support entity inheritance for Flutter
  // https://docs.objectbox.io/advanced/entity-inheritance
  get identifier2;

  enumIndexValid(int index, int length) {
    return index >= 0 && index < length;
  }

  U enumValueByIndex<T extends List<U>, U>(int index, T values, U defaultValue) {
    return enumIndexValid(index, values.length) ? values[index] : defaultValue;
  }
}
