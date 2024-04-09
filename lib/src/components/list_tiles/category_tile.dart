import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mall/src/extensions/build_context.dart';
import 'package:mall/src/utils/styles.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const CategoryTile(
      {super.key,
      required this.title,
      required this.onDelete,
      required this.onEdit,
      required this.onTap,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) => onDelete(),
            backgroundColor: context.onError.withOpacity(0.5),
            foregroundColor: context.onBackground,
            icon: Icons.delete_forever,
            label: 'Delete',
          ),
          SizedBox(
            width: 5,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) => onEdit(),
            backgroundColor: context.secondary.withOpacity(0.5),
            foregroundColor: context.onBackground,
            icon: Icons.edit_note,
            label: 'Edit',
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Adjust padding
        leading: Icon(
          iconData, // Example icon
          color:
              Theme.of(context).colorScheme.secondary, // Icon color from theme
        ),
        title: Text(
          title,
          style:
              largeStyle.copyWith(color: context.tertiary), // Adjust font size
        ),

        minVerticalPadding: 0,
        onTap: () {
          onTap();
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Rounded corners for ListTile
        ),
        tileColor: Theme.of(context)
            .colorScheme
            .surface, // Background color from theme
        trailing: Icon(
          Icons.chevron_right, // Trailing icon
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(0.6), // Trailing icon color
        ),
      ),
    );
    ;
  }
}
