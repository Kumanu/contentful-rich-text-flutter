import 'package:contentful_rich_text/types/blocks.dart';

class TopLevelBlockEnum {
  final String _key;
  final BLOCKS _value;
  const TopLevelBlockEnum._internal(this._key, this._value);

  @override
  String toString() => 'TopLevelBlockEnum.$_key';
  String get key => _key;
  BLOCKS get value => _value;
  operator [](dynamic index) => index is int
      ? items[index]
      : index is String
          ? items.firstWhere((item) => item.key == index, orElse: () => null)
          : null;

  static const PARAGRAPH =
      const TopLevelBlockEnum._internal('PARAGRAPH', BLOCKS.PARAGRAPH);
  static const HEADING_1 =
      const TopLevelBlockEnum._internal('HEADING_1', BLOCKS.HEADING_1);
  static const HEADING_2 =
      const TopLevelBlockEnum._internal('HEADING_2', BLOCKS.HEADING_2);
  static const HEADING_3 =
      const TopLevelBlockEnum._internal('HEADING_3', BLOCKS.HEADING_2);
  static const HEADING_4 =
      const TopLevelBlockEnum._internal('HEADING_4', BLOCKS.HEADING_2);
  static const HEADING_5 =
      const TopLevelBlockEnum._internal('HEADING_5', BLOCKS.HEADING_2);
  static const HEADING_6 =
      const TopLevelBlockEnum._internal('HEADING_6', BLOCKS.HEADING_2);
  static const OL_LIST =
      const TopLevelBlockEnum._internal('OL_LIST', BLOCKS.OL_LIST);
  static const UL_LIST =
      const TopLevelBlockEnum._internal('UL_LIST', BLOCKS.UL_LIST);
  static const HR = const TopLevelBlockEnum._internal('HR', BLOCKS.HR);
  static const QUOTE = const TopLevelBlockEnum._internal('QUOTE', BLOCKS.QUOTE);
  static const EMBEDDED_ENTRY = const TopLevelBlockEnum._internal(
      'EMBEDDED_ENTRY', BLOCKS.EMBEDDED_ENTRY);
  static const EMBEDDED_ASSET = const TopLevelBlockEnum._internal(
      'EMBEDDED_ASSET', BLOCKS.EMBEDDED_ASSET);

  // Helpers
  static List<TopLevelBlockEnum> get items => [
        PARAGRAPH,
        HEADING_1,
        HEADING_2,
        HEADING_3,
        HEADING_4,
        HEADING_5,
        HEADING_6,
        OL_LIST,
        UL_LIST,
        HR,
        QUOTE,
        EMBEDDED_ENTRY,
        EMBEDDED_ASSET,
      ];
  static fromKey(String key) {
    return items.firstWhere((item) => item.key == key, orElse: () => null);
  }

  static fromValue(dynamic value) {
    if (value is BLOCKS) {
      return items.firstWhere((item) => item.value == value,
          orElse: () => null);
    }
    if (value is String) {
      return items.firstWhere((item) => item.value.value == value,
          orElse: () => null);
    }
  }

  /// Array of all top level block types.
  /// Only these block types can be the direct children of the document.
  static const List<BLOCKS> TOP_LEVEL_BLOCKS = [
    BLOCKS.PARAGRAPH,
    BLOCKS.HEADING_1,
    BLOCKS.HEADING_2,
    BLOCKS.HEADING_3,
    BLOCKS.HEADING_4,
    BLOCKS.HEADING_5,
    BLOCKS.HEADING_6,
    BLOCKS.OL_LIST,
    BLOCKS.UL_LIST,
    BLOCKS.HR,
    BLOCKS.QUOTE,
    BLOCKS.EMBEDDED_ENTRY,
    BLOCKS.EMBEDDED_ASSET,
  ];

  /// Array of all void block types
  static const List<BLOCKS> VOID_BLOCKS = [
    BLOCKS.HR,
    BLOCKS.EMBEDDED_ENTRY,
    BLOCKS.EMBEDDED_ASSET,
  ];

  /// Dictionary of all container block types, and the set block types they accept as children.
  static const Map<BLOCKS, List<BLOCKS>> CONTAINERS = {
    BLOCKS.OL_LIST: [BLOCKS.LIST_ITEM],
    BLOCKS.UL_LIST: [BLOCKS.LIST_ITEM],
    BLOCKS.LIST_ITEM: TOP_LEVEL_BLOCKS,
    BLOCKS.QUOTE: [BLOCKS.PARAGRAPH],
  };
}
