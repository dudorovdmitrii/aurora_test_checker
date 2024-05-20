import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'Constants.dart';

part 'SettingsTheme.freezed.dart';

@freezed
class SettingsThemeData with _$SettingsThemeData {
  const factory SettingsThemeData.light({
    @Default(TopGColors.quickSilver) Color buttonColor,
    @Default(TopGColors.blueCrayola) Color blockTitleColor,
    @Default(TopGColors.blackFogra) Color blockColor,
    @Default(TopGColors.quickSilver) Color iconColor,
    @Default(Color.fromARGB(255, 178, 185, 248)) Color backgroundColor,
    @Default(TopGColors.quickSilver) Color dividerColor,
  }) = _SettingsThemeDataLight;

  const factory SettingsThemeData.dark({
    @Default(TopGColors.quickSilver) Color buttonColor,
    @Default(TopGColors.blueCrayola) Color blockTitleColor,
    @Default(TopGColors.white) Color blockColor,
    @Default(TopGColors.quickSilver) Color iconColor,
    @Default(Color.fromARGB(255, 69, 83, 209)) Color backgroundColor,
    @Default(TopGColors.quickSilver) Color dividerColor,
  }) = _SettingsThemeDataDark;
}
