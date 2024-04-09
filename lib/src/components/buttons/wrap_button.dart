import 'package:flutter/material.dart';
import 'package:mall/src/extensions/build_context.dart';

class MyWrapButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const MyWrapButton({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: context.backgroud,
          border: Border.all(color: context.tertiary, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
            child: Text(
              text,
              style: TextStyle(color: context.tertiary),
            ),
          )),
    );
  }
}
