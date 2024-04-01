import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(color: Colors.purple, themeMode: ThemeMode.dark)) {
    on<ThemeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(color: event.color, themeMode: event.themeMode));
    });
  }
}
