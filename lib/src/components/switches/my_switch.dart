import 'package:flutter/material.dart';

class MyArrowSwitch extends StatelessWidget {
  final String title;
  final bool isHistoryVisible;
  final VoidCallback onTap;
  MyArrowSwitch(
      {super.key,
      required this.isHistoryVisible,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    print(isHistoryVisible);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title),
            isHistoryVisible
                ? Icon(
                    Icons.arrow_drop_up,
                    size: 25,
                  )
                : Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  )
          ],
        ),
      ),
    );
  }
}
