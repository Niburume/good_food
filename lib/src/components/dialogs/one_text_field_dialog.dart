import 'package:flutter/material.dart';
import 'package:mall/src/components/card/card.dart';
import 'package:mall/src/components/my_textfield.dart';

import '../../modules/add_item_bar/bloc/add_item_bar_cubit.dart';

class MyOneTextFieldDialog extends StatelessWidget {
  final AddItemBarCubit barCubit;
  final String title;
  final String initialValue;
  final String hintText;
  final IconData iconData;
  final TextInputType? keyboardType;

  MyOneTextFieldDialog(
      {required this.barCubit,
      super.key,
      required this.title,
      required this.hintText,
      required this.iconData,
      this.keyboardType,
      this.initialValue = ''});
  final FocusNode _textFieldFocusNode = FocusNode();
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _textFieldFocusNode.requestFocus();
    _textFieldController.text = initialValue;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: MyTextField(
                maxLines: 10,
                keyboardType: keyboardType,
                controller: _textFieldController,
                focusNode: _textFieldFocusNode,
                hintText: hintText,
                icon: iconData,
                onChange: () {},
                onClear: () {},
                onSubmitted: () {},
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, _textFieldController.text);
                  },
                  child: Text('Ok'))
            ],
          )
        ],
      ),
    );
  }
}
