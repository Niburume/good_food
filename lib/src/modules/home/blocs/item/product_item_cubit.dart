import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mall/src/modules/home/model/product_item_view_model.dart';

import '../../model/dummyModel.dart';

part 'product_item_state.dart';

List<MyProductItem> _productItems = List.generate(
  10,
  (index) => MyProductItem.empty.copyWith(
      id: UniqueKey().toString(),
      name: 'value is $index',
      isChecked: index % 2 == 0,
      category: index % 2 == 0 ? 'some cat $index' : 'another cat'),
);

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListState());

  void setAllProducts() async {
    List<MyProductItemViewModel> completedItems = [];
    List<MyProductItemViewModel> uncompletedItems = [];

    _productItems.forEach((element) {
      if (element.isChecked)
        completedItems.insert(0, MyProductItemViewModel(productItem: element));
      if (!element.isChecked)
        uncompletedItems.insert(
            0, MyProductItemViewModel(productItem: element));
    });
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(
        completedViewItems: completedItems,
        uncompletedViewItems: uncompletedItems,
        status: ListStatus.normal));
  }

  void insertItem(MyProductItem item) {
    final List<MyProductItemViewModel> updatedList =
        List<MyProductItemViewModel>.from(state.uncompletedModels)
          ..insert(
              0, MyProductItemViewModel(productItem: item, isLoading: true));

    emit(state.copyWith(
        uncompletedViewItems: updatedList,
        actionsState: ListActionState.insert));

    // Use unawaited for the delay and subsequent state update
    unawaited(Future.delayed(Duration(milliseconds: 1000)).then((_) {
      final int index = state.uncompletedModels
          .indexWhere((element) => element.productItem.id == item.id);
      final List<MyProductItemViewModel> finalList =
          List<MyProductItemViewModel>.from(state.uncompletedModels)
            ..[index] =
                MyProductItemViewModel(productItem: item, isLoading: false);

      emit(state.copyWith(
          uncompletedViewItems: finalList,
          actionsState: ListActionState.normal));
    }));
  }

  void toggleFavorite(MyProductItem item) async {
    List<MyProductItemViewModel> items = List.from(state.uncompletedModels);
    MyProductItem oldItem = items
        .firstWhere((element) => element.productItem.id == item.id)
        .productItem;
    MyProductItem updatedItem =
        oldItem.copyWith(isFavorite: !oldItem.isFavorite);
    items.removeWhere((element) => element.productItem.id == item.id);
    int insertIndex = oldItem.isFavorite ? items.length : 0;
    items.insert(
        insertIndex,
        MyProductItemViewModel(
            productItem: updatedItem, isFavoriteAnimating: true));
    emit(state.copyWith(
        uncompletedViewItems: items, actionsState: ListActionState.favorite));
    unawaited(Future.delayed(Duration(milliseconds: 700)).then((result) {
      List<MyProductItemViewModel> items = List.from(state.uncompletedModels);
      var updatedItems = items
          .map((e) => e.productItem.id == oldItem.id
              ? e.copyWith(isFavoriteAnimating: false)
              : e)
          .toList();
      emit(state.copyWith(uncompletedViewItems: updatedItems));
    }));
  }

  void completeItem(MyProductItem item, int index) async {
    final List<MyProductItemViewModel> updatedCompletedList =
        List<MyProductItemViewModel>.from(state.completedModels)
          ..insert(
              0,
              MyProductItemViewModel(
                  productItem: item.copyWith(isChecked: true),
                  isLoading: true,
                  isCompleteAnimation: true));

    final List<MyProductItemViewModel> updatedUnCompletedList =
        List<MyProductItemViewModel>.from(state.uncompletedModels)
          ..removeWhere((element) => element.productItem.id == item.id);

    emit(state.copyWith(
        completedViewItems: updatedCompletedList,
        uncompletedViewItems: updatedUnCompletedList,
        actionsState: ListActionState.complete,
        actionItemIndex: index));
    unawaited(Future.delayed(Duration(milliseconds: 1500)).then((value) {
      var updatedItemModels = state.completedModels
          .map((e) => e.productItem.id == item.id
              ? e.copyWith(isLoading: false, isCompleteAnimation: false)
              : e)
          .toList();
      emit(state.copyWith(
          completedViewItems: updatedItemModels,
          actionsState: ListActionState.normal,
          actionItemIndex: -1));
    }));
  }

  void unCompleteItem(MyProductItem item, int index) async {
    final List<MyProductItemViewModel> updatedUnCompletedList =
        List<MyProductItemViewModel>.from(state.uncompletedModels)
          ..insert(
              0,
              MyProductItemViewModel(
                  productItem: item.copyWith(isChecked: false),
                  isLoading: true,
                  isCompleteAnimation: true));

    final List<MyProductItemViewModel> updatedCompletedList =
        List<MyProductItemViewModel>.from(state.completedModels)
          ..removeWhere((element) => element.productItem.id == item.id);

    emit(state.copyWith(
        completedViewItems: updatedCompletedList,
        uncompletedViewItems: updatedUnCompletedList,
        actionsState: ListActionState.unComplete,
        actionItemIndex: index));
    unawaited(Future.delayed(Duration(milliseconds: 500)).then((value) {
      var updatedItemModels = state.uncompletedModels
          .map((e) => e.productItem.id == item.id
              ? e.copyWith(isLoading: false, isCompleteAnimation: false)
              : e)
          .toList();
      emit(state.copyWith(
          uncompletedViewItems: updatedItemModels,
          actionsState: ListActionState.normal,
          actionItemIndex: -1));
    }));
  }

  void reorderItems(MyProductItemViewModel itemModel, int oldIndex,
      int newIndex, bool isCompleted) {
    final List<MyProductItemViewModel> updatedListModels =
        List<MyProductItemViewModel>.from(
            isCompleted ? state.completedModels : state.uncompletedModels)
          ..removeAt(oldIndex)
          ..insert(oldIndex < newIndex ? newIndex - 1 : newIndex, itemModel);
    ;

    isCompleted
        ? emit(state.copyWith(completedViewItems: updatedListModels))
        : emit(state.copyWith(uncompletedViewItems: updatedListModels));
  }

  void toggleReorderAbleState() {
    emit(state.copyWith(isReorderAbleState: !state.isReorderAbleState));
  }
}
