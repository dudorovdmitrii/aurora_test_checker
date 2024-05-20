import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ThemeModes.dart';
import 'Constants.dart';
import 'SettingsTheme.dart';

part 'ThemeData.freezed.dart';

@freezed
class TopGThemeData with _$TopGThemeData {
  const factory TopGThemeData.light({
    @Default(TopGMode.light) TopGMode mode,
    @Default(TopGColorScheme.light) ColorScheme colorScheme,
    @Default(SettingsThemeData.light()) SettingsThemeData settings,
  }) = _TopGThemeDataLight;

  const factory TopGThemeData.dark({
    @Default(TopGMode.dark) TopGMode mode,
    @Default(TopGColorScheme.dark) ColorScheme colorScheme,
    @Default(SettingsThemeData.dark()) SettingsThemeData settings,
  }) = _TopGThemeDataDark;
}
