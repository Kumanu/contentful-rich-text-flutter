/// Map of all Contentful inlines
class INLINES {
  final String _key;
  final String _value;
  const INLINES._internal(this._key, this._value);

  @override
  String toString() => 'INLINES.$_key';
  String get key => _key;
  String get value => _value;

  static const HYPERLINK = const INLINES._internal('HYPERLINK', 'hyperlink');
  static const ENTRY_HYPERLINK = const INLINES._internal('ENTRY_HYPERLINK', 'entry-hyperlink');
  static const ASSET_HYPERLINK = const INLINES._internal('ASSET_HYPERLINK', 'asset-hyperlink');
  static const EMBEDDED_ENTRY = const INLINES._internal('EMBEDDED_ENTRY', 'embedded-entry-inline');

  static List<String> get keys => ['HYPERLINK', 'ENTRY_HYPERLINK', 'ASSET_HYPERLINK', 'EMBEDDED_ENTRY'];
  static List<String> get values => ['hyperlink', 'entry-hyperlink', 'asset-hyperlink', 'embedded-entry-inline'];
}
