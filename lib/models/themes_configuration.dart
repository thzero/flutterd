import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

class ThemesConfiguration {
  static ThemeData darkTheme(int theme) {
    return _maps[theme]!.dark;
  }

  static ThemeData theme(int theme) {
    return _maps[theme]!.light;
  }

  static init(ThemeTypes types) {
    if (Platform.isIOS || Platform.isMacOS) {
      return;
    }

    types.init();

    themes.addAll(types.themes);

    themes.forEach((key, value) {
      _maps[key] = AppThemeItem(key, value.scheme);
    });
  }

  static final Map<int, AppThemeItem> _maps = {};
  static final Map<int, ThemeTypeInfo> themes = {};
}

// https://rydmike.com/flexcolorscheme/themesplayground-v5/#/
class AppThemeItem {
  AppThemeItem(this.type, FlexScheme scheme) {
    dark = FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarStyle: FlexAppBarStyle.background,
      appBarOpacity: 0.90,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 30,
        appBarBackgroundSchemeColor: SchemeColor.onPrimary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,

        interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorIsFilled: true,
    inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 12),
    inputDecoratorBackgroundAlpha: 7,
    inputDecoratorBorderSchemeColor: SchemeColor.primary,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorRadius: 8.0,
    inputDecoratorUnfocusedBorderIsColored: true,
    inputDecoratorBorderWidth: 1.0,
    inputDecoratorFocusedBorderWidth: 2.0,
    inputDecoratorPrefixIconSchemeColor: SchemeColor.onPrimaryFixedVariant,
    inputDecoratorSuffixIconSchemeColor: SchemeColor.primary,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
    light = FlexThemeData.light(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 20,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  int type;
  late ThemeData dark;
  late ThemeData light;
}

abstract class ThemeTypes {
  void add(int theme, String name, scheme) {
    themes[theme] = ThemeTypeInfo(name, scheme);
  }

  init();

  final Map<int, ThemeTypeInfo> themes = {};
}

class ThemeTypeInfo {
  final String name;
  final FlexScheme scheme;
  const ThemeTypeInfo(this.name, this.scheme);
}

class StandardThemeTypes extends ThemeTypes {
  @override
  init() {
    add(0, 'blue', FlexScheme.blue);
    add(1, 'green', FlexScheme.green);
    add(2, 'orange', FlexScheme.gold);
    add(3, 'red', FlexScheme.red);
    add(4, 'purple', FlexScheme.indigo);
  }
}
