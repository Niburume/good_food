import 'package:flutter/material.dart';
import 'package:mall/src/components/restart/restart_widget.dart';
import 'package:mall/src/modules/themes/theme_bloc.dart';
import 'package:mall/src/utils/theme/theme.dart';

import 'src/components/persistent_nav.dart';
import 'src/modules/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'src/modules/auth/views/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  final ThemeBloc themeBloc;

  MyAppView({required this.themeBloc, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: themeBloc,
      child: RestartWidget(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          bloc: themeBloc,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'YOUR_APP_NAME',
              themeMode: themeBloc.state.themeMode,
              theme: getTheme(seedColor: themeBloc.state.color),
              darkTheme:
                  getTheme(seedColor: themeBloc.state.color, isLight: false),
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state.status == AuthenticationStatus.authenticated) {
                    return PersistentTabScreen();
                  } else {
                    return const WelcomePage();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
