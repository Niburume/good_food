List<String> filterValues({
  required String value,
  required List<String> values,
  int limit = 0,
}) {
  List<String> filteredValues = [];
  List<String> valueParts = value.trim().toUpperCase().split(' ');

  for (final element in values) {
    bool containsAllParts =
        valueParts.every((part) => element.trim().toUpperCase().contains(part));

    if (containsAllParts) {
      filteredValues.add(element);
      if (limit > 0 && filteredValues.length == limit) break;
    }
  }

  return filteredValues;
}
