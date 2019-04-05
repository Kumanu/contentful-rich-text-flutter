/// Map of all Contentful block types.
/// Blocks contain inline or block nodes.
class BLOCKS {
  final String _key;
  final String _value;
  const BLOCKS._internal(this._key, this._value);

  @override
  String toString() => 'BLOCKS.$_key';
  String get key => _key;
  String get value => _value;
  operator [](dynamic index) => index is int
      ? items[index]
      : index is String
          ? items.firstWhere((item) => item.key == index, orElse: () => null)
          : null;

  static const DOCUMENT = const BLOCKS._internal('DOCUMENT', 'document');
  static const PARAGRAPH = const BLOCKS._internal('PARAGRAPH', 'paragraph');
  static const HEADING_1 = const BLOCKS._internal('HEADING_1', 'heading-1');
  static const HEADING_2 = const BLOCKS._internal('HEADING_2', 'heading-2');
  static const HEADING_3 = const BLOCKS._internal('HEADING_3', 'heading-3');
  static const HEADING_4 = const BLOCKS._internal('HEADING_4', 'heading-4');
  static const HEADING_5 = const BLOCKS._internal('HEADING_5', 'heading-5');
  static const HEADING_6 = const BLOCKS._internal('HEADING_6', 'heading-6');
  static const OL_LIST = const BLOCKS._internal('OL_LIST', 'ordered-list');
  static const UL_LIST = const BLOCKS._internal('UL_LIST', 'unordered-list');
  static const LIST_ITEM = const BLOCKS._internal('LIST_ITEM', 'list-item');
  static const HR = const BLOCKS._internal('HR', 'hr');
  static const QUOTE = const BLOCKS._internal('QUOTE', 'blockquote');
  static const EMBEDDED_ENTRY =
      const BLOCKS._internal('EMBEDDED_ENTRY', 'embedded-entry-block');
  static const EMBEDDED_ASSET =
      const BLOCKS._internal('EMBEDDED_ASSET', 'embedded-asset-block');

  // Helpers
  static List<BLOCKS> get items => [
        DOCUMENT,
        PARAGRAPH,
        HEADING_1,
        HEADING_2,
        HEADING_3,
        HEADING_4,
        HEADING_5,
        HEADING_6,
        OL_LIST,
        UL_LIST,
        LIST_ITEM,
        HR,
        QUOTE,
        EMBEDDED_ENTRY,
        EMBEDDED_ASSET,
      ];
  static fromKey(String key) {
    return items.firstWhere((item) => item.key == key, orElse: () => null);
  }

  static fromValue(String value) {
    return items.firstWhere((item) => item.value == value, orElse: () => null);
  }
}
