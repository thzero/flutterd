import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Copyright {
  final String authors;
  final int? yearConsecutiveStart;
  final String? yearsNonConsecutive;
  Copyright(this.authors, {this.yearConsecutiveStart, this.yearsNonConsecutive});

  String get yearsComplete {
    if (yearsNonConsecutive != null) {
      return yearsNonConsecutive!;
    }

    if (yearConsecutiveStart != null) {
      int year = DateTime.now().year;
      if (yearConsecutiveStart! == year) {
        return yearConsecutiveStart.toString();
      }
      if (yearConsecutiveStart! > year) {
        return year.toString();
      }

      return '${yearConsecutiveStart!.toString()}-${year.toString()}';
    }

    return '';
  }
}

class Utilities {
  static Copyright? copyright;

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
