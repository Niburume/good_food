part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<MyProductItem> allProducts;

  ProductListLoaded({required this.allProducts});

  @override
  List<Object> get props => [allProducts];
}

class ProductListError extends ProductListState {}

class ProductListLoading extends ProductListState {}
