import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
import 'package:http/http.dart' as http;
import 'package:mutex/mutex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CachedNetworkFileTranslationLoader extends NetworkFileTranslationLoader {
  static final Mutex _mutexCheck = Mutex();
  static final Mutex _mutexUpdate = Mutex();
  String? _directory;
  int timeout = 1000 * 60 * 60 * 15; // TODO: config
  PackageInfo? _info;

  CachedNetworkFileTranslationLoader({required baseUri, forcedLocale, fallbackFile = "en", useCountryCode = false, useScriptCode = false, decodeStrategies})
      : super(baseUri: baseUri, fallbackFile: fallbackFile, useCountryCode: useCountryCode, forcedLocale: forcedLocale, decodeStrategies: decodeStrategies);

  /// Load the file using an http client
  @override
  Future<String> loadString(final String fileName, final String extension) async {
    final resolvedUri = resolveUri(fileName, extension);
    final result = await http.get(resolvedUri);
    if (result.statusCode != 200) {
      return "";
    }
    return result.body;
  }

  @override
  @protected
  Future<Map> loadFile(String fileName) async {
    try {
      _info ??= await PackageInfo.fromPlatform();

      if (_directory == null) {
        final directory = await getApplicationDocumentsDirectory();
        _directory = directory.path;
      }

      File file = File('$_directory/$fileName');
      if (await file.exists()) {
        Map? results = await _validate(file);
        if (results != null) {
          return results;
        }
      }

      return await _mutexCheck.protect(() async {
        if (await file.exists()) {
          Map? results = await _validate(file);
          if (results != null) {
            return results;
          }
        }

        return await _mutexUpdate.protect(() async {
          if (await file.exists()) {
            Map? results = await _validate(file);
            if (results != null) {
              return results;
            }
          }

          Map map = await super.loadFile(fileName);
          Map output = {keyTtl: DateTime.now().millisecondsSinceEpoch, keyVersion: _info!.version, keyData: map};
          file.writeAsString(jsonEncode(output));
          return map;
        });
      });
    } catch (ex) {
      return {};
    }
  }

  @override
  Uri resolveUri(final String fileName, final String extension) {
    return baseUri.resolve(resolveFile(fileName, extension));
  }

  String resolveFile(final String fileName, final String extension) {
    return '$fileName.$extension';
  }

  Future<Map?> _validate(File file) async {
    int ttl = DateTime.now().millisecondsSinceEpoch;
    Map map = jsonDecode(await file.readAsString());
    if (map.isEmpty) {
      return null;
    }
    if (map[keyVersion] != null) {
      String? version = map[keyVersion];
      if (version != null && version.isNotEmpty) {
        if (version == _info!.version) {
          return map[keyData];
        }
      }
    }

    if (map[keyTtl] != null) {
      int? ttl2 = map[keyTtl];
      if (ttl2 == null) {
        return null;
      }

      int delta = ttl - ttl2;
      if (delta > timeout) {
        return null;
      }
    }

    return map[keyData];
  }

  static const String keyData = "data";
  static const String keyTtl = "ttl";
  static const String keyVersion = "version";
}
