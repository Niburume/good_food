part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final Color color;
  final ThemeMode themeMode;

  ThemeState({required this.color, required this.themeMode});

  List<Object> get props => [color, themeMode];

  ThemeState copyWith({
    Color? color,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      color: color ?? this.color,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
