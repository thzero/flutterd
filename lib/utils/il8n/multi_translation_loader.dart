import 'package:flutter/foundation.dart';

import 'package:flutter_i18n/loaders/file_translation_loader.dart';

import 'package:thzero_library/utils/il8n/cached_network_translation_loader.dart';

class MultiTranslationLoader extends FileTranslationLoader {
  late CachedNetworkFileTranslationLoader _networkFileTranslationLoader;

  MultiTranslationLoader({baseUri, basePath = "assets/i18n", fallbackFile = "en", useCountryCode = false, useScriptCode = false, forcedLocale, decodeStrategies})
      : super(basePath: basePath, fallbackFile: fallbackFile, useCountryCode: useCountryCode, useScriptCode: useScriptCode, forcedLocale: forcedLocale, decodeStrategies: decodeStrategies) {
    _networkFileTranslationLoader = CachedNetworkFileTranslationLoader(baseUri: baseUri);
  }

  /// Load the fileName using one of the strategies provided
  @override
  @protected
  Future<Map> loadFile(final String fileName) async {
    Map? temp;
    try {
      temp = await super.loadFile(fileName);
      if (temp.isNotEmpty) {
        return temp;
      }
    } catch (ex) {
      temp = null;
    }
    if (temp == null || temp.isEmpty) {
      temp = await _networkFileTranslationLoader.loadFile(fileName);
      return temp;
    }
    return {};
  }
}
