part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllProductsEvent extends ProductListEvent {}

class AddItemEvent extends ProductListEvent {
  final MyProductItem product;

  @override
  List<Object> get props => [product];

  AddItemEvent(this.product);
}
