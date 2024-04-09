import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mall/src/modules/home/model/product_item_view_model.dart';
import 'package:mall/src/utils/filter/filter.dart';

import '../../../utils/constants/string_constants.dart';

part 'add_item_bar_state.dart';

class AddItemBarCubit extends Cubit<AddItemBarState> {
  AddItemBarCubit() : super(AddItemBarState.empty);
  void clear() {
    emit(state.copyWith(
        status: AddItemBarStatus.initial,
        actionStatus: AddItemBarAction.idle,
        currentValue: '',
        filteredWrapperValues: [],
        period: {kDay: 0, kMonth: 0, kYear: 0},
        note: '',
        category: '',
        tag: '',
        amount: 1));
  }

  // region SUGGESTION WRAPPER
  void setSearchValuesForWrapper(
      List<MyProductItemViewModel> productItemViewModels) {
    List<String> values =
        productItemViewModels.map((e) => e.productItem.name).toList();
    List<String> categories = productItemViewModels
        .map((e) => e.productItem.category)
        .toSet()
        .toList();
    emit(state.copyWith(
        valuesForWrapper: values,
        categories: categories,
        filteredCategories: categories));
  }

  void filterWrapper(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(filteredWrapperValues: []));
      return;
    }
    List<String> filteredValues =
        filterValues(value: value, values: state.valuesForWrapper, limit: 10);

    emit(state.copyWith(filteredWrapperValues: filteredValues));
  }
// endregion

  // region Category
  setCurrentCategory(String category) {
    emit(state.copyWith(category: category));
  }

  removeCategory() {
    emit(state.copyWith(category: ''));
  }

  filterCategories(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(filteredCategories: state.categories));
      return;
    }

    var filteredValues = filterValues(value: value, values: state.categories);
    emit(state.copyWith(filteredCategories: filteredValues));
  }

  addNewCategory(String category) {
    List<String> categories = List.from(state.categories);
    print(categories.length);
    categories.insert(0, category);
    print(categories.length);
    emit(state.copyWith(
        category: category,
        categories: categories,
        filteredCategories: categories));
  }
  // endregion

// region CURRENT VALUE
  void setCurrentValue(String value) {
    emit(state.copyWith(
        currentValue: value, actionStatus: AddItemBarAction.currentState));
    filterWrapper(value);
    emit(state.copyWith(actionStatus: AddItemBarAction.idle));
  }

// endregion

  // region PERIOD
  void setPeriod(Map<String, int> period) {
    emit(state.copyWith(period: period));
  }

  void clearPeriod() {
    emit(state.copyWith(period: {kDay: 0, kMonth: 0, kYear: 0}));
  }
  // endregion

  // region NOTE
  void saveNote(String note) {
    emit(state.copyWith(note: note));
  }

  void clearNote() {
    emit(state.copyWith(note: ''));
  }
  // endregion

  // region AMOUNT
  void incrementCounter() {
    emit(state.copyWith(amount: (state.amount) + 1));
  }

  void decrementCounter() {
    if (state.amount <= 1) return;
    emit(state.copyWith(amount: (state.amount) - 1));
  }

  void setAmount(String amount) {
    emit(state.copyWith(amount: int.tryParse(amount) ?? 1));
  }
  // endregion
}
