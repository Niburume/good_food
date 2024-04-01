import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback onChange;
  final VoidCallback onClear;
  final VoidCallback onSubmitted;
  final IconData icon;
  final String hintText;
  const CustomSearchTextField(
      {required this.controller,
      required this.onChange,
      required this.onClear,
      required this.onSubmitted,
      this.focusNode,
      this.icon = Icons.search,
      this.hintText = 'Search...',
      super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: (value) {
        widget.onSubmitted();
      },
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.tertiary,
        ),

        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  widget.controller.clear();
                  setState(() {});
                },
              )
            : null,
        // Icon inside the search bar
        hintText: widget.hintText, // Placeholder text
        // Background color of the text field
        filled: true, // Enable the fillColor
        border: OutlineInputBorder(
          // Defines the border of the text field
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          borderSide: BorderSide.none, // Removes the underline border
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 0, horizontal: 20), // Padding inside the text field
        enabledBorder: OutlineInputBorder(
          // Border style when the text field is enabled but not focused
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          // Border style when the text field is focused
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
