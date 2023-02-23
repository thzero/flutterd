class Response {
  final bool success;
  final String? message;
  final int? code;

  Response(this.success, {this.message, this.code});

  static bool hasFailed(Response? response) {
    return response == null || !response.success;
  }

  static bool hasSucceed(Response? response) {
    return response != null && response.success;
  }

  static Response isFailure() {
    return Response(false);
  }

  static Response isFailureDirty() {
    return Response(false, code: codeDirty);
  }

  static Response isFailureFound() {
    return Response(false, code: codeFound);
  }

  static Response isFailureNotFound() {
    return Response(false, code: codeNotFound);
  }

  static Response isSuccess() {
    return Response(true);
  }

  static Response isSuccessNotFound() {
    return Response(true, code: codeNotFound);
  }

  static int codeDirty = 1;
  static int codeFound = 2;
  static int codeNotFound = 3;
}

class UpdateResponse extends Response {
  UpdateResponse(bool success, {String? message, int? code}) : super(success, message: message, code: code);

  static bool hasFailed(UpdateResponse? response) {
    return response == null || !response.success;
  }

  static bool hasSucceed(UpdateResponse? response) {
    return response != null && response.success;
  }

  static UpdateResponse isFailure() {
    return UpdateResponse(false);
  }

  static UpdateResponse isFailureDirty() {
    return UpdateResponse(false, code: Response.codeDirty);
  }

  static UpdateResponse isFailureFound() {
    return UpdateResponse(false, code: Response.codeFound);
  }

  static UpdateResponse isFailureNotFound() {
    return UpdateResponse(false, code: Response.codeNotFound);
  }

  static UpdateResponse isSuccess() {
    return UpdateResponse(true);
  }

  static UpdateResponse isSuccessNotFound() {
    return UpdateResponse(true, code: Response.codeNotFound);
  }
}

class ResponseData<T> extends Response {
  final T? data;

  ResponseData(this.data, bool success, {String? message, int? code}) : super(success, message: message, code: code);

  static bool hasFailed(ResponseData? response) {
    return response == null || !response.success || response.data == null;
  }

  static bool hasSucceed(ResponseData? response) {
    return response != null && response.success && response.data != null;
  }

  static ResponseData<T> isFailure<T>() {
    return ResponseData<T>(null, false);
  }

  static ResponseData<T> isFailureDirty<T>() {
    return ResponseData<T>(null, false, code: Response.codeDirty);
  }

  static ResponseData<T> isFailureNotFound<T>() {
    return ResponseData<T>(null, false, code: Response.codeNotFound);
  }

  static ResponseData<T> isSuccess<T>(T? data) {
    return ResponseData<T>(data, true);
  }
}
