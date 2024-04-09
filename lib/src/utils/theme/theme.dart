import 'package:flutter/material.dart';

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
