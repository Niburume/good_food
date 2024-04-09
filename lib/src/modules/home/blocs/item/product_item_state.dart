part of 'product_item_cubit.dart';

enum ListStatus { loading, normal, failure, empty }

enum ListActionState {
  normal,
  favorite,
  insert,
  delete,
  rename,
  complete,
  unComplete
}

class ProductListState extends Equatable {
  final List<MyProductItemViewModel> uncompletedModels;
  final List<MyProductItemViewModel> completedModels;
  final ListStatus status;
  final ListActionState actionState;
  final bool isReorderAbleState;
  final int actionItemIndex;
  ProductListState(
      {this.uncompletedModels = const [],
      this.completedModels = const [],
      this.status = ListStatus.loading,
      this.actionState = ListActionState.normal,
      this.isReorderAbleState = false,
      this.actionItemIndex = -1});

  @override
  List<Object?> get props => [
        status,
        isReorderAbleState,
        actionState,
        uncompletedModels,
        completedModels,
        actionItemIndex
      ];

  int? getItemById(String itemId) {
    int index;
    index = completedModels
        .indexWhere((element) => element.productItem.id == itemId);
    if (index == -1) {
      index = uncompletedModels
          .indexWhere((element) => element.productItem.id == itemId);
    }
    return index;
  }

  ProductListState copyWith({
    List<MyProductItemViewModel>? uncompletedViewItems,
    List<MyProductItemViewModel>? completedViewItems,
    ListStatus? status,
    bool? isReorderAbleState,
    ListActionState? actionsState,
    int? actionItemIndex,
  }) {
    return ProductListState(
        uncompletedModels: uncompletedViewItems ?? this.uncompletedModels,
        completedModels: completedViewItems ?? this.completedModels,
        status: status ?? this.status,
        isReorderAbleState: isReorderAbleState ?? this.isReorderAbleState,
        actionState: actionsState ?? this.actionState,
        actionItemIndex: actionItemIndex ?? this.actionItemIndex);
  }
}
