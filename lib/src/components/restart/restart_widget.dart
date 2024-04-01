// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  // static void restartLocale(BuildContext context, Locale locale) {
  //   context
  //       .findAncestorStateOfType<_RestartWidgetState>()
  //       ?._restartLocale(locale);
  // }

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?._restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  // void _restartLocale(Locale locale) async {
  //   setState(() {
  //     context.setLocale(locale);
  //     key = UniqueKey();
  //   });
  // }

  void _restartApp() async {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
