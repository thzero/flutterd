import 'package:flutter/rendering.dart';

extension ColorX on Color {
  String toHexTriplet() => '#'
      '${(a * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${(r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${(g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${(b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}';
}
