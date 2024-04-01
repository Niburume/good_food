class MyProductItem {
  final String id;
  final DateTime dateStamp;
  final int period;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final double price;
  final bool isChecked;
  final bool isFavorite;

  const MyProductItem({
    required this.id,
    required this.dateStamp,
    required this.period,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.isChecked,
    required this.isFavorite,
  });

  static final empty = MyProductItem(
      id: '',
      dateStamp: DateTime.utc(0),
      period: 0,
      name: '',
      category: '',
      imageUrl: '',
      description: '',
      price: 0.0,
      isChecked: false,
      isFavorite: false);

  MyProductItem copyWith({
    String? id,
    DateTime? dateStamp,
    int? period,
    String? name,
    String? category,
    String? imageUrl,
    String? description,
    double? price,
    bool? isChecked,
    bool? isFavorite,
  }) {
    return MyProductItem(
      id: id ?? this.id,
      dateStamp: dateStamp ?? this.dateStamp,
      period: period ?? this.period,
      name: name ?? this.name,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      isChecked: isChecked ?? this.isChecked,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
