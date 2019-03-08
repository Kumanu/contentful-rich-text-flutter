/// Map of all Contentful marks
class MARKS {
  final String _key;
  final String _value;
  const MARKS._internal(this._key, this._value);

  @override
  String toString() => 'MARKS.$_key';
  String get key => _key;
  String get value => _value;
  operator [](dynamic index) => index is int
      ? items[index]
      : index is String ? items.firstWhere((item) => item.key == index, orElse: () => null) : null;

  static const BOLD = const MARKS._internal('BOLD', 'bold');
  static const ITALIC = const MARKS._internal('ITALIC', 'italic');
  static const UNDERLINE = const MARKS._internal('UNDERLINE', 'underline');

  // Helpers
  static List<MARKS> get items => [
        BOLD,
        ITALIC,
        UNDERLINE,
      ];
  static fromKey(String key) {
    return items.firstWhere((item) => item.key == key, orElse: () => null);
  }

  static fromValue(String value) {
    return items.firstWhere((item) => item.value == value, orElse: () => null);
  }
}
