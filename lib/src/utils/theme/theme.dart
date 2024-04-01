import 'package:flutter/material.dart';
import 'package:mall/src/utils/theme/custom_themes/app_bar_theme.dart';

ThemeData getTheme({required Color seedColor, bool isLight = true}) {
  return isLight
      ? ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: seedColor,
          ))
      : ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: seedColor,
          ));
}
