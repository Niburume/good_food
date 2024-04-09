import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/components/list_tiles/product_tile.dart';
import 'package:mall/src/modules/home/blocs/item/product_item_cubit.dart';

import '../model/dummyModel.dart';
import '../model/product_item_view_model.dart';

class MyReorderAbleList extends StatefulWidget {
  final bool isCompletedItemsView;
  const MyReorderAbleList({required this.isCompletedItemsView, super.key});

  @override
  State<MyReorderAbleList> createState() => _MyReorderAbleListState();
}

class _MyReorderAbleListState extends State<MyReorderAbleList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<MyProductItemViewModel> viewItems = [];
  void insertItem() {
    if (!widget.isCompletedItemsView) _listKey.currentState!.insertItem(0);
  }

  void toggleFavorite(MyProductItem item) {
    context.read<ProductListCubit>().toggleFavorite(item);
  }

  void completeItem() {
    if (!widget.isCompletedItemsView) {
      _listKey.currentState!.removeItem(
        context.read<ProductListCubit>().state.actionItemIndex,
        (context, animation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves
                .easeOut, // Use any curve from Curves class or define your own
          );
          // This builder is responsible for the remove animation
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(
              opacity: curvedAnimation,

              child: KProductTile(
                isLoading: false,
                productViewModel: MyProductItemViewModel(
                    productItem: MyProductItem.empty.copyWith(isChecked: true)),
                onFavoriteTapped: () {},
                onCheckTapped: () {},
              ), // Customize with your list item widget
            ),
          );
        },
        duration: Duration(milliseconds: 400),
        // Customize duration of the animation
      );
    }
    if (widget.isCompletedItemsView) _listKey.currentState!.insertItem(0);
  }

  void unCompleteItem() {
    if (!widget.isCompletedItemsView) _listKey.currentState!.insertItem(0);
    if (widget.isCompletedItemsView) {
      _listKey.currentState!.removeItem(
        context.read<ProductListCubit>().state.actionItemIndex,
        (context, animation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves
                .easeOut, // Use any curve from Curves class or define your own
          );
          // This builder is responsible for the remove animation
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(
              opacity: curvedAnimation,

              child: KProductTile(
                isLoading: false,
                productViewModel: MyProductItemViewModel(
                    productItem:
                        MyProductItem.empty.copyWith(isChecked: false)),
                onFavoriteTapped: () {},
                onCheckTapped: () {},
              ), // Customize with your list item widget
            ),
          );
        },
        duration: Duration(milliseconds: 400),
        // Customize duration of the animation
      );
    }
  }

  void removeItem(int index) {}

  @override
  Widget build(BuildContext context) {
    // _items = widget.productListBloc.state;
    return BlocConsumer<ProductListCubit, ProductListState>(
      listener: (context, current) {
        switch (current.actionState) {
          case ListActionState.insert:
            insertItem();
          case ListActionState.complete:
            completeItem();
          case ListActionState.unComplete:
            unCompleteItem();
          default:
            () {};
        }
        ;
      },
      builder: (context, state) {
        viewItems = widget.isCompletedItemsView
            ? state.completedModels
            : state.uncompletedModels;
        // state.productItemViewModels.forEach((element) {
        //   print(element.isLoading);
        // });
        return Container(
          child: state.isReorderAbleState
              ? ReorderableListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = viewItems[index].productItem;

                    return KProductTile(
                      key: ValueKey(item.id),
                      isReorderAbleView: true,
                      productViewModel: viewItems[index],
                      onFavoriteTapped: () {},
                      onCheckTapped: () {},
                      onDeleteTapped: () {},
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    context.read<ProductListCubit>().reorderItems(
                        viewItems[oldIndex],
                        oldIndex,
                        newIndex,
                        widget.isCompletedItemsView);
                  },
                  itemCount: viewItems.length,
                )
              : GestureDetector(
                  onTap: () {
                    // insertItem();
                  },
                  child: AnimatedList(
                      key: _listKey,
                      shrinkWrap: true,
                      initialItemCount: viewItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index, animation) {
                        var item = viewItems[index].productItem;
                        return SizeTransition(
                          sizeFactor: CurvedAnimation(
                            parent: animation,
                            curve: Curves
                                .easeIn, // This affects the animation's feel
                            // You can experiment with different curves here
                          ),
                          child: GestureDetector(
                            onLongPress: () {
                              context
                                  .read<ProductListCubit>()
                                  .toggleReorderAbleState();
                            },
                            child: KProductTile(
                              key: ValueKey(item.id),
                              isLoading: viewItems[index].isLoading,
                              productViewModel: viewItems[index],
                              isFavoriteAnimates:
                                  viewItems[index].isFavoriteAnimating,
                              onFavoriteTapped: () {
                                toggleFavorite(viewItems[index].productItem);
                              },
                              onCheckTapped: () {
                                widget.isCompletedItemsView
                                    ? context
                                        .read<ProductListCubit>()
                                        .unCompleteItem(item, index)
                                    : context
                                        .read<ProductListCubit>()
                                        .completeItem(item, index);
                              },
                              onDeleteTapped: () {
                                print('Here we go');
                              },
                            ),
                          ),
                        );
                      }),
                ),
        );
      },
    );
  }
}
