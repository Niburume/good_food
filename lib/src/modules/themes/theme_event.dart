part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final Color? color;
  final ThemeMode? themeMode;
  const ChangeThemeEvent(this.color, this.themeMode);

  @override
  List<Object?> get props => [color, themeMode];
}
