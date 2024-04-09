import 'package:flutter/material.dart';
import 'package:mall/src/extensions/build_context.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final double padding;
  MyCard({required this.child, this.padding = 5, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroud,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.tertiary,
            // Specify border color here
            width: 1.0, // Specify border width here
          ),

          // If you want to keep the background color from the theme, you can set it here too.
        ),
        child: child,
      ),
    );
  }
}
