extension StrFormat on String {
  String get firstCapital {
    List<String> values = split('');
    values[0] = values[0].toUpperCase();
    return values.join();
  }
}

extension CutString on String {
  String cutString(int length) {
    return length >= this.length ? this : (substring(0, length) + '...');
  }
}
