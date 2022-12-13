import 'dart:async';

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

  static void delayMis<T>(FutureOr<T> Function() computation, {int delay = 50}) {
    Future.delayed(Duration(microseconds: delay), computation);
  }

  static void delayMs<T>(FutureOr<T> Function() computation, {int delay = 50}) {
    Future.delayed(Duration(milliseconds: delay), computation);
  }

  static String generateId() {
    return const Uuid().v4();
  }

  static bool isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isEmptyBool(bool? value) {
    return value == null;
  }

  static bool isEmptyDateTime(DateTime? value) {
    return value == null;
  }

  static bool isEmptyDouble(double? value) {
    return value == null;
  }

  static bool isEmptyInt(int? value) {
    return value == null;
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isNotEmptyBool(bool? value) {
    return value != null;
  }

  static bool isNotEmptyDateTime(DateTime? value) {
    return value != null;
  }

  static bool isNotEmptyDouble(double? value) {
    return value != null;
  }

  static bool isNotEmptyInt(int? value) {
    return value != null;
  }

  static TapGestureRecognizer tapGestureLaunchUri(Uri uri) {
    return TapGestureRecognizer()
      ..onTap = () {
        launchUrl(uri, mode: LaunchMode.externalApplication);
      };
  }

  static int timestamp() {
    return DateTime.now().toUtc().millisecondsSinceEpoch;
  }

  static int timestampMs() {
    return DateTime.now().toUtc().millisecondsSinceEpoch;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
