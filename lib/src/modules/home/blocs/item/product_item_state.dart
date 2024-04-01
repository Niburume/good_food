part of 'product_item_cubit.dart';

class ProductItemState extends Equatable {
  final List<MyProductItem> allProducts;

  ProductItemState({this.allProducts = const []});

  List<MyProductItem> get completedProducts {
    return allProducts.where((element) => element.isChecked == true).toList();
  }

  List<MyProductItem> get products {
    return allProducts.where((element) => element.isChecked == false).toList();
  }

  int indexById(String id) {
    return allProducts.indexWhere((element) => element.id == id);
  }

  @override
  List<Object?> get props => [allProducts];

  ProductItemState copyWith({
    List<MyProductItem>? allProducts,
  }) {
    return ProductItemState(
      allProducts: allProducts ?? this.allProducts,
    );
  }
}
