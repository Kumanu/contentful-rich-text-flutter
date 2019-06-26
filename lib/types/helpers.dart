import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';

class Helpers {
  /// Checks if the node is an instance of Inline
  static bool isInline(dynamic node) {
    return INLINES.fromValue(node['nodeType']) != null;
  }

  /// Checks if the node is an instance of Block
  static bool isBlock(dynamic node) {
    return BLOCKS.fromValue(node['nodeType']) != null;
  }

  /// Checks if the node is an instance of TopLevelBlocks
  static bool isTopLevelBlock(dynamic node) {
    return TopLevelBlockEnum.fromValue(node['nodeType']);
  }

  /// Checks if the node is an instance of Paragraph
  static bool isParagraph(dynamic node) {
    return node['nodeType'] == 'paragraph';
  }

  /// Checks if the node is a Header
  static bool isHeader(dynamic node) {
    return node['nodeType'].contains('heading');
  }

  /// Checks if the node is an instance of Text
  static bool isText(dynamic node) {
    return node['nodeType'] == 'text';
  }

  /// Checks if the node is an instance of Hyperlink
  static bool isHyperlink(dynamic node) {
    return node['nodeType'] == 'hyperlink';
  }
}
