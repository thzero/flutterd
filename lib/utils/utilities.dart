import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Utilities {
  static String convertToFixedDecimal(double? value) {
    if (value == null) {
      return '';
    }

    return value.toStringAsFixed(2);
  }

  static String generateId() {
    return const Uuid().v4();
  }

  static TapGestureRecognizer tapGestureLaunchUri(Uri uri) {
    return TapGestureRecognizer()
      ..onTap = () {
        launchUrl(uri, mode: LaunchMode.externalApplication);
      };
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
