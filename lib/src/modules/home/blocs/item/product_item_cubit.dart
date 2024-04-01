import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/dummyModel.dart';

part 'product_item_state.dart';

class ProductItemCubit extends Cubit<ProductItemState> {
  ProductItemCubit() : super(ProductItemState());

  void setAllProducts(List<MyProductItem> products) {
    emit(state.copyWith(allProducts: products));
  }

  void uncheckItem(MyProductItem product) {
    int index = state.indexById(product.id);
    List<MyProductItem> products = List.from(state.allProducts);
    products[index] = product.copyWith(isChecked: false);
    emit(state.copyWith(allProducts: products));
  }

  void checkItem(MyProductItem product) {
    int index = state.indexById(product.id);
    List<MyProductItem> products = List.from(state.allProducts);
    products[index] = product.copyWith(isChecked: true);
    emit(state.copyWith(allProducts: products));
  }

  void removeItem(MyProductItem product) {
    // state.productItems.removeWhere((element) => element.id == product.id);
  }
}
