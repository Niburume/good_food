import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:mall/src/components/buttons/icon_button.dart';
import 'package:mall/src/components/card/card.dart';
import 'package:mall/src/components/dialogs/one_text_field_dialog.dart';
import 'package:mall/src/components/list_tiles/category_tile.dart';

import 'package:mall/src/components/my_textfield.dart';

import '../../modules/add_item_bar/bloc/add_item_bar_cubit.dart';

class PickItemScreen extends StatefulWidget {
  final AddItemBarCubit barCubit;
  final String title;
  final List<String> initialValues;
  final String hintText;
  final IconData iconData;
  final TextInputType? keyboardType;

  PickItemScreen(
      {required this.barCubit,
      super.key,
      required this.title,
      required this.hintText,
      required this.iconData,
      this.keyboardType,
      this.initialValues = const []});

  @override
  State<PickItemScreen> createState() => _PickItemScreenState();
}

class _PickItemScreenState extends State<PickItemScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _isAddButtonVisible = false;
  final FocusNode _textFieldFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFieldFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(widget.title),
              ),
              SliverList.builder(
                  itemCount: widget.barCubit.state.filteredCategories.length,
                  itemBuilder: (context, i) {
                    print(
                        'length: ${widget.barCubit.state.filteredCategories.length}');
                    return CategoryTile(
                      iconData: widget.barCubit.state.filteredCategories ==
                              widget.barCubit.state.filteredCategories[i]
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      title: widget.barCubit.state.filteredCategories[i],
                      onTap: () {
                        Navigator.pop(context,
                            widget.barCubit.state.filteredCategories[i]);
                      },
                      onDelete: () {},
                      onEdit: () {},
                    );
                  }),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyTextField(
                            onChange: () {
                              widget.barCubit
                                  .filterCategories(_textFieldController.text);
                              setState(() {
                                _isAddButtonVisible =
                                    _textFieldController.text.isNotEmpty &&
                                        widget.barCubit.state.filteredCategories
                                            .isEmpty;
                              });
                            },
                            focusNode: _textFieldFocusNode,
                            controller: _textFieldController,
                            hintText: widget.hintText,
                          ),
                        ),
                        AnimatedSize(
                          duration: Duration(
                              milliseconds: 300), // Customize to your liking
                          child: _isAddButtonVisible
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Animate(
                                    child: MyIconButton(
                                      iconData: Icons.add_circle_outline,
                                      size: 30,
                                      onTap: () async {
                                        widget.barCubit.addNewCategory(
                                            _textFieldController.text);

                                        Navigator.pop(context,
                                            widget.barCubit.state.category);
                                      },
                                    ).animate().scale().rotate(delay: 200.ms),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
