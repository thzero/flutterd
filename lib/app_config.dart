import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

typedef ConfigConstructionFunc<T> = Future<T> Function(Map<String, dynamic> json);

abstract class BaseConfig {}

abstract class AppConfigFactory {
  static Future<T> forEnvironment<T extends BaseConfig>(ConfigConstructionFunc<T> func) async {
    String env = kReleaseMode ? 'prod' : 'dev';
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    return await func(jsonDecode(contents));
  }
}
