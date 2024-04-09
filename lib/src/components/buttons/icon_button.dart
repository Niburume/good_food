import 'package:flutter/material.dart';
import 'package:mall/src/extensions/build_context.dart';

class MyIconButton extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color? color;
  final VoidCallback onTap;
  const MyIconButton(
      {super.key,
      required this.iconData,
      this.size = 25,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        iconData,
        size: size,
        color: color ?? context.tertiary,
      ),
    );
  }
}
