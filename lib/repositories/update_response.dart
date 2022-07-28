class UpdateResponse {
  final bool success;
  final String? message;
  final int? code;

  UpdateResponse(this.success, {this.message, this.code});

  static isFailure() {
    return UpdateResponse(false);
  }

  static isFailureDirty() {
    return UpdateResponse(false, code: codeDirty);
  }

  static isFailureFound() {
    return UpdateResponse(false, code: codeFound);
  }

  static isFailureNotFound() {
    return UpdateResponse(false, code: codeNotFound);
  }

  static isSuccess() {
    return UpdateResponse(true);
  }

  static int codeDirty = 1;
  static int codeFound = 2;
  static int codeNotFound = 3;
}

class UpdateResponseData<T> extends UpdateResponse {
  final T? data;

  UpdateResponseData(this.data, bool success, {String? message, int? code}) : super(success, message: message, code: code);

  static isFailure<T>(T? data) {
    return UpdateResponseData<T>(data, false);
  }

  static isFailureDirty<T>(T? data) {
    return UpdateResponseData<T>(data, false, code: UpdateResponse.codeDirty);
  }

  static isFailureNotFound<T>(T? data) {
    return UpdateResponseData<T>(data, false, code: UpdateResponse.codeNotFound);
  }

  static isSuccess<T>(T data) {
    return UpdateResponseData<T>(data, true);
  }
}
