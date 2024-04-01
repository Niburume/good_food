import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/utils/styles.dart';

class KSettingListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget trailingWidget;
  const KSettingListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AutoSizeText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              title,
              style: largeStyle),
        ),
        SizedBox(
          width: 10,
        ),
        trailingWidget,
      ],
    );
  }
}
