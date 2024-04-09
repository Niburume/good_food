import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall/src/components/buttons/icon_button.dart';
import 'package:mall/src/components/buttons/my_general_button.dart';
import 'package:mall/src/components/buttons/wrap_button.dart';
import 'package:mall/src/components/card/card.dart';
import 'package:mall/src/components/dialogs/list_items_dialog.dart';
import 'package:mall/src/extensions/build_context.dart';
import 'package:mall/src/extensions/str_extension.dart';
import 'package:mall/src/modules/add_item_bar/bloc/add_item_bar_cubit.dart';
import 'package:mall/src/components/dialogs/one_text_field_dialog.dart';
import 'package:mall/src/utils/constants/string_constants.dart';

import '../../../utils/styles.dart';
import '../../pick_item_screen/pick_item_screen.dart';

class MyAddItemBar extends StatelessWidget {
  final String text;
  const MyAddItemBar({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    AddItemBarCubit _barCubit = context.read<AddItemBarCubit>();
    // Example list of a
    return BlocBuilder<AddItemBarCubit, AddItemBarState>(
      bloc: _barCubit,
      builder: (context, state) {
        return MyCard(
          child: Column(
            children: [
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 4.0, // Gap between adjacent chips.
                        runSpacing: 8.0, // Gap between lines.
                        children: _barCubit.state.filteredWrapperValues
                            .map((e) => Animate(
                                child: MyWrapButton(
                                    text: e,
                                    onTap: () {
                                      _barCubit.setCurrentValue(e);
                                    })).animate().fadeIn())
                            .toList(),
                      ),
                    ),
                    if (state.filteredWrapperValues.isNotEmpty)
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: context.tertiary.withOpacity(0.5),
                      ),
                  ],
                ),
              ),
              // region CurrentCategory
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                child: Row(
                  children: [
                    state.category != ''
                        ? _removableButton(
                            context: context,
                            title: state.category,
                            onRemove: () {
                              _barCubit.removeCategory();
                            },
                          )
                        : Container(),
                    (state.periodIsEmpty)
                        ? Container()
                        : _removableButton(
                            context: context,
                            title: state.shortStringPeriod,
                            onRemove: () {
                              _barCubit.clearPeriod();
                            }),
                    state.note != ''
                        ? _removableButton(
                            context: context,
                            title: state.note.cutString(30),
                            onRemove: () {
                              _barCubit.clearNote();
                            })
                        : Container()
                  ],
                ),
              ),
              // endregion
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 4,
                  top: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyCard(
                      padding: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8.0),
                        child: Row(
                          children: [
                            // region PERIOD
                            MyIconButton(
                                iconData: state.periodIsEmpty
                                    ? Icons.more_time
                                    : Icons.schedule,
                                color: state.periodIsEmpty
                                    ? null
                                    : context.primary,
                                onTap: () {
                                  Map<String, int> period =
                                      Map.from(state.period);
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height /
                                              2.5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 10),
                                                child: Text(
                                                  'Period',
                                                  style: largeStyle,
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    _picker(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        initialValue:
                                                            period[kDay]!,
                                                        title: 'Days',
                                                        amount: 31,
                                                        onSelection: (value) {
                                                          period[kDay] = value;
                                                        }),
                                                    _picker(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        title: 'Months',
                                                        amount: 12,
                                                        onSelection: (value) {
                                                          period[kMonth] =
                                                              value;
                                                        }),
                                                    _picker(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        title: 'Years',
                                                        amount: 5,
                                                        onSelection: (value) {
                                                          period[kYear] = value;
                                                        }),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: MyGeneralButton(
                                                          title: 'Cancel',
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: MyGeneralButton(
                                                          title: 'Ok',
                                                          onTap: () {
                                                            _barCubit.setPeriod(
                                                                period);
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                }),
                            // endregion
                            // region CATEGORY
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: MyIconButton(
                                  iconData: _barCubit.state.category.isNotEmpty
                                      ? Icons.document_scanner_outlined
                                      : Icons.list_alt,
                                  color: _barCubit.state.category.isNotEmpty
                                      ? context.primary
                                      : null,
                                  onTap: () async {
                                    String? category = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PickItemScreen(
                                                barCubit: _barCubit,
                                                title: 'Pick the item',
                                                hintText:
                                                    'Search or add new category...',
                                                iconData: Icons.add)));
                                    if (category == null) return;
                                    _barCubit.setCurrentCategory(category);
                                  }),
                            ),
                            // endregion
                            // region NOTE
                            MyIconButton(
                                iconData: _barCubit.state.note.isNotEmpty
                                    ? Icons.sticky_note_2_rounded
                                    : Icons.note_add,
                                color: _barCubit.state.note.isNotEmpty
                                    ? context.primary
                                    : null,
                                onTap: () async {
                                  String value = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          content: MyOneTextFieldDialog(
                                        barCubit: _barCubit,
                                        title: 'Add some note here',
                                        hintText: 'Note...',
                                        iconData: Icons.sticky_note_2_outlined,
                                        initialValue: state.note,
                                      ));
                                    },
                                  );
                                  _barCubit.saveNote(value);
                                })
                            // endregion
                          ],
                        ),
                      ),
                    ),
                    // region COUNTER
                    MyCard(
                      padding: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8.0),
                        child: Row(
                          children: [
                            MyIconButton(
                                iconData: Icons.remove_circle_outline,
                                onTap: () {
                                  _barCubit.decrementCounter();
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                children: [
                                  IntrinsicWidth(
                                    stepWidth:
                                        40.0, // Optional: Forces increments in multiples of this value
                                    child: Container(
                                      alignment: Alignment
                                          .center, // To center the text within the larger width
                                      child: InkWell(
                                        onTap: () async {
                                          String value = await showDialog(
                                              context: context,
                                              builder: (newContext) =>
                                                  AlertDialog(
                                                    content:
                                                        MyOneTextFieldDialog(
                                                      barCubit: _barCubit,
                                                      title:
                                                          'Set amount for this item',
                                                      hintText: '1',
                                                      iconData: Icons.layers,
                                                      initialValue: state.amount
                                                          .toString(),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ));
                                          _barCubit.setAmount(value);
                                        },
                                        child: Text(
                                          context
                                              .watch<AddItemBarCubit>()
                                              .state
                                              .amount
                                              .toString(),
                                          style: boldStyle.copyWith(
                                              color: context.secondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MyIconButton(
                                iconData: Icons.add_circle_outline,
                                onTap: () {
                                  _barCubit.incrementCounter();
                                })
                          ],
                        ),
                      ),
                    )
                    // endregion
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _picker(
      {required String title,
      required int amount,
      final int initialValue = 0,
      double width = 100,
      required Function(int value) onSelection}) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(title),
          Expanded(
            child: CupertinoPicker(
              magnification: 1.22,
              scrollController: FixedExtentScrollController(
                initialItem: initialValue,
              ),
              children: List.generate(
                  amount + 1, (index) => Text((index).toString())),
              itemExtent: 32, // Height of each item
              onSelectedItemChanged: (int index) {
                onSelection(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _removableButton(
      {required BuildContext context,
      required String title,
      required VoidCallback onRemove}) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: InkWell(
          onTap: () {
            onRemove();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  title,
                  style:
                      TextStyle(color: context.onBackground.withOpacity(0.7)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Icons.cancel_outlined,
                  size: 15,
                  color: context.tertiary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
