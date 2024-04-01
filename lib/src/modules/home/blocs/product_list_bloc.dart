import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/dummyModel.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

// DUMY DATA
List<MyProductItem> _productItems = List.generate(
  10,
  (index) => MyProductItem.empty.copyWith(
      id: index.toString(), name: 'value is $index', isChecked: index % 2 == 0),
);

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<LoadAllProductsEvent>(_loadAllProducts);
  }
  void _loadAllProducts(
      LoadAllProductsEvent event, Emitter<ProductListState> emit) async {
    try {
      emit(ProductListLoading());
      await Future.delayed(Duration(milliseconds: 300));

      emit(ProductListLoaded(allProducts: _productItems));
    } catch (e) {
      emit(ProductListError());
      Exception(e.toString());
    }
  }
}
