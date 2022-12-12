import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:flutterd/repositories/external/external_repository.dart';
import 'package:flutterd/repositories/external/mime_constants.dart';

abstract class HttpExternalRepository extends ExternalRepository {
  HttpResultsResponse parseResponse(http.Response httpResponse, String key) {
    HttpResultsResponse response = HttpResultsResponse();
    if (httpResponse.statusCode != 200) {
      return response.failed();
    }

    dynamic body = json.decode(httpResponse.body);
    if (body.isEmpty) {
      return response.failed();
    }
    dynamic results2 = body[key];
    if (results2 != null) {
      return response.successResults(results2);
    }
    return response.failed();
  }

  HttpResultsResponse parseResponseResults(http.Response httpResponse, {String? key}) {
    HttpResultsResponse response = HttpResultsResponse();
    if (httpResponse.statusCode != 200) {
      return response.failed();
    }

    dynamic body = json.decode(httpResponse.body);
    if (body.isEmpty) {
      return response.failed();
    }
    dynamic success = body['success'] as bool;
    if (success == null || (success != null && success! == false)) {
      return response.failed();
    }
    dynamic results2 = body['results'];
    if (results2 != null) {
      if (key != null && key.isNotEmpty) {
        return response.successResults(results2[key]);
      }
      return response.successResults(results2);
    }
    return response.failed();
  }

  Future<Response> postJson(Uri uri, Map<String, Object?> body, {Map<String, String>? headers, Duration? timeout}) async {
    headers ??= {};
    headers[HttpHeaders.contentTypeHeader] = MimeConstants.json;
    var post = http.post(uri, headers: headers, body: json.encode(body));
    if (timeout != null) {
      post = post.timeout(timeout);
    }
    return await post;
  }
}

class HttpResultsResponse {
  bool success = true;
  dynamic results;

  HttpResultsResponse failed() {
    success = false;
    return this;
  }

  HttpResultsResponse successResults(dynamic results) {
    this.results = results;
    success = true;
    return this;
  }
}

class HttpExternalResponse<T> extends ExternalResponse<T> {}
