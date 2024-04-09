import 'package:flutter/material.dart';
import 'package:mall/src/extensions/build_context.dart';

class MyGeneralButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const MyGeneralButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(color: context.tertiary),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: context.tertiary, width: 2),
      ),
    );
  }
}
