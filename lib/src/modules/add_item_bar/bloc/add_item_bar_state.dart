part of 'add_item_bar_cubit.dart';

enum AddItemBarStatus { initial, idle, failure, isSending }

enum AddItemBarAction {
  period,
  category,
  note,
  tag,
  wrap,
  increment,
  decrement,
  idle,
  currentState
}

class AddItemBarState extends Equatable {
  final AddItemBarStatus status;
  final AddItemBarAction actionStatus;

  final List<String> valuesForWrapper;
  final List<String> filteredWrapperValues;
  final List<String> categories;
  final List<String> filteredCategories;
  final String currentValue;
  final Map<String, int> period;
  final String category;
  final String note;
  final String tag;
  final int amount;

  @override
  List<Object> get props => [
        status,
        actionStatus,
        valuesForWrapper,
        filteredCategories,
        categories,
        currentValue,
        filteredWrapperValues,
        period,
        category,
        note,
        tag,
        amount,
      ];

  const AddItemBarState({
    required this.status,
    required this.actionStatus,
    required this.categories,
    required this.filteredCategories,
    required this.currentValue,
    required this.valuesForWrapper,
    required this.filteredWrapperValues,
    required this.period,
    required this.category,
    required this.note,
    required this.tag,
    required this.amount,
  });

  static final empty = AddItemBarState(
      status: AddItemBarStatus.initial,
      actionStatus: AddItemBarAction.idle,
      currentValue: '',
      categories: const [],
      filteredCategories: const [],
      valuesForWrapper: const [],
      filteredWrapperValues: const [],
      period: const {kDay: 0, kMonth: 0, kYear: 0},
      category: '',
      note: '',
      tag: '',
      amount: 1);

  get periodIsEmpty {
    return (period[kDay] == 0 && period[kMonth] == 0 && period[kYear] == 0);
  }

  get shortStringPeriod {
    String days = period[kDay] == 0 ? '' : '${period[kDay]} d. ';
    String month = period[kMonth] == 0 ? '' : '${period[kMonth]} m. ';
    String year = period[kYear] == 0 ? '' : '${period[kYear]} y. ';
    return days + month + year;
  }

  AddItemBarState copyWith({
    AddItemBarStatus? status,
    AddItemBarAction? actionStatus,
    List<String>? categories,
    List<String>? filteredCategories,
    String? currentValue,
    List<String>? valuesForWrapper,
    List<String>? filteredWrapperValues,
    Map<String, int>? period,
    String? category,
    String? note,
    String? tag,
    int? amount,
  }) {
    return AddItemBarState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      currentValue: currentValue ?? this.currentValue,
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      valuesForWrapper: valuesForWrapper ?? this.valuesForWrapper,
      filteredWrapperValues:
          filteredWrapperValues ?? this.filteredWrapperValues,
      period: period ?? this.period,
      category: category ?? this.category,
      note: note ?? this.note,
      tag: tag ?? this.tag,
      amount: amount ?? this.amount,
    );
  }
}
