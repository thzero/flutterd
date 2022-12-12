abstract class ExternalRepository {}

class ExternalResponse<T> {
  bool success = true;
  T? results;

  static ExternalResponse<T> failed<T>() {
    final result = ExternalResponse<T>();
    result.success = false;
    return result;
  }

  static ExternalResponse<T> successResults<T>(T results) {
    final result = ExternalResponse<T>();
    result.results = results;
    result.success = true;
    return result;
  }
}
