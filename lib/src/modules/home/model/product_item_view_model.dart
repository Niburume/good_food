import 'package:mall/src/modules/home/model/dummyModel.dart';

class MyProductItemViewModel {
  final MyProductItem productItem;
  final bool isLoading;
  final bool isFavoriteAnimating;
  final bool isCompleteAnimation;

  MyProductItemViewModel(
      {required this.productItem,
      this.isLoading = false,
      this.isFavoriteAnimating = false,
      this.isCompleteAnimation = false});

  MyProductItemViewModel copyWith(
      {MyProductItem? productItem,
      bool? isLoading,
      bool? isFavoriteAnimating,
      bool? isCompleteAnimation}) {
    return MyProductItemViewModel(
        productItem: productItem ?? this.productItem,
        isLoading: isLoading ?? this.isLoading,
        isFavoriteAnimating: isFavoriteAnimating ?? this.isFavoriteAnimating,
        isCompleteAnimation: isCompleteAnimation ?? this.isCompleteAnimation);
  }
}
