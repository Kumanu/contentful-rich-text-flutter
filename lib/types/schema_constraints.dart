import 'package:collection/collection.dart' show IterableExtension;
import 'package:contentful_rich_text/types/blocks.dart';

class TopLevelBlockEnum {
  final String _key;
  final BLOCKS _value;
  const TopLevelBlockEnum._internal(this._key, this._value);

  @override
  String toString() => 'TopLevelBlockEnum.$_key';
  String get key => _key;
  BLOCKS get value => _value;

  operator [](dynamic index) {
    if (index is int) {
      return index <= items.length ? items[index] : null;
    }
    if (index is String) {
      return items.firstWhereOrNull((item) => item.key == index);
    }
    return null;
  }

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
  static TopLevelBlockEnum? fromKey(String key) =>
      items.firstWhereOrNull((item) => item.key == key);

  static TopLevelBlockEnum? fromValue(dynamic value) {
    if (value is BLOCKS) {
      return items.firstWhereOrNull((item) => item.value == value);
    }
    if (value is String) {
      return items.firstWhereOrNull((item) => item.value.value == value);
    }
    return null;
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
