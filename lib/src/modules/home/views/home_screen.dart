import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/components/my_textfield.dart';
import 'package:mall/src/components/switches/my_switch.dart';
import 'package:mall/src/extensions/build_context.dart';
import 'package:mall/src/modules/add_item_bar/bloc/add_item_bar_cubit.dart';
import 'package:mall/src/modules/home/blocs/item/product_item_cubit.dart';

import 'package:mall/src/modules/home/views/my_reordable_listview.dart';

import '../../add_item_bar/views/add_item_bar.dart';

import '../model/dummyModel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isHistoryVisible = false;
  bool _isItemBarVisible = false;

  late final AnimationController _animationController;

  final TextEditingController _addItemController = TextEditingController();
  final FocusNode _addItemFocusNode = FocusNode();

  // region ITEMS
  void addItem() {
    if (_addItemController.text.isEmpty) return;
    context.read<ProductListCubit>().insertItem(MyProductItem.empty
        .copyWith(id: UniqueKey().toString(), name: _addItemController.text));
    _addItemController.clear();
    _addItemFocusNode.requestFocus();
    context.read<AddItemBarCubit>().clear();
    setState(() {});
  }

  void onChange() {
    context.read<AddItemBarCubit>().filterWrapper(_addItemController.text);
  }

  void onCheckTapped(MyProductItem product, int index) {}

  // endregion

  void showHistory() {
    _isHistoryVisible = !_isHistoryVisible;
    setState(() {});
  }

  _onFocusChange() {
    if (_addItemFocusNode.hasFocus) {
      _isItemBarVisible = true;
      setState(() {});
    } else {
      _isItemBarVisible = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this);
    _addItemFocusNode.addListener(() {
      _onFocusChange();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _addItemController.dispose();
    _addItemFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBarCubit, AddItemBarState>(
      listener: (context, state) {
        if (state.actionStatus == AddItemBarAction.currentState) {
          _addItemController.text = state.currentValue;
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            if (context.watch<ProductListCubit>().state.isReorderAbleState)
              IconButton(
                onPressed: () {
                  context.read<ProductListCubit>().toggleReorderAbleState();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Animate(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 30,
                      color: context.primary,
                    ),
                  )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .flipH(
                          delay: 300.ms, duration: 1000.ms, begin: 0, end: 1),
                ),
              )
          ],
        ),
        body: BlocConsumer<ProductListCubit, ProductListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == ListStatus.normal) {
              if (context
                  .read<AddItemBarCubit>()
                  .state
                  .valuesForWrapper
                  .isEmpty)
                context.read<AddItemBarCubit>().setSearchValuesForWrapper(
                    state.completedModels + state.uncompletedModels);
              return Stack(
                children: [
                  SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        MyReorderAbleList(
                          key: ValueKey(1),
                          isCompletedItemsView: false,
                        ),
                        MyArrowSwitch(
                            isHistoryVisible: _isHistoryVisible,
                            title: 'show history',
                            onTap: () {
                              showHistory();
                            }),
                        AnimatedOpacity(
                          opacity: _isHistoryVisible ? 1 : 0,
                          duration: Duration(milliseconds: 800),
                          child: AnimatedContainer(
                            height: _isHistoryVisible ? 500 : 0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: MyReorderAbleList(
                              key: ValueKey(2),
                              isCompletedItemsView: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: context
                            .read<ProductListCubit>()
                            .state
                            .isReorderAbleState
                        ? 0
                        : 1,
                    duration: Duration(milliseconds: 300),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AnimatedOpacity(
                              opacity: _isItemBarVisible ? 1 : 0,
                              duration: Duration(milliseconds: 300),
                              child: _isItemBarVisible
                                  ? MyAddItemBar(
                                      text: _addItemController.text,
                                    )
                                  : SizedBox.shrink(),
                            ),
                            MyTextField(
                                controller: _addItemController,
                                focusNode: _addItemFocusNode,
                                hintText: 'Add item...',
                                onChange: () {
                                  onChange();
                                },
                                onClear: () {},
                                onSubmitted: () {
                                  addItem();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.status == ListStatus.loading) {
              return Center(
                child: SizedBox(
                    height: 60, width: 60, child: CircularProgressIndicator()),
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}
