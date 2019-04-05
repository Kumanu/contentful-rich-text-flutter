/// Map of all Contentful inlines
class INLINES {
  final String _key;
  final String _value;
  const INLINES._internal(this._key, this._value);

  @override
  String toString() => 'INLINES.$_key';
  String get key => _key;
  String get value => _value;
  operator [](dynamic index) => index is int
      ? items[index]
      : index is String
          ? items.firstWhere((item) => item.key == index, orElse: () => null)
          : null;

  static const HYPERLINK = const INLINES._internal('HYPERLINK', 'hyperlink');
  static const ENTRY_HYPERLINK =
      const INLINES._internal('ENTRY_HYPERLINK', 'entry-hyperlink');
  static const ASSET_HYPERLINK =
      const INLINES._internal('ASSET_HYPERLINK', 'asset-hyperlink');
  static const EMBEDDED_ENTRY =
      const INLINES._internal('EMBEDDED_ENTRY', 'embedded-entry-inline');

  // Helpers
  static List<INLINES> get items => [
        HYPERLINK,
        ENTRY_HYPERLINK,
        ASSET_HYPERLINK,
        EMBEDDED_ENTRY,
      ];
  static fromKey(String key) {
    return items.firstWhere((item) => item.key == key, orElse: () => null);
  }

  static fromValue(String value) {
    return items.firstWhere((item) => item.value == value, orElse: () => null);
  }
}
