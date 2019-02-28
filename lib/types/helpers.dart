import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';

class Helpers {
  /// Checks if the node is an instance of Inline
  static bool isInline(dynamic node) {
    return INLINES.values.contains(node['nodeType']);
  }

  /// Checks if the node is an instance of Block
  static bool isBlock(dynamic node) {
    return BLOCKS.values.contains(node['nodeType']);
  }

  /// Checks if the node is an instance of TopLevelBlocks
  static bool isTopLevelBlock(dynamic node) {
    return TopLevelBlockEnum.values.contains(node['nodeType']);
  }

  /// Checks if the node is an instance of Paragraph
  static bool isParagraph(dynamic node) {
    print('isParagraph: ${node['nodeType']}');
    return node['nodeType'] == 'paragraph';
  }

  /// Checks if the node is a Header
  static bool isHeader(dynamic node) {
    print('isHeader: ${node['nodeType']}');
    return node['nodeType'].contains('heading');
  }

  /// Checks if the node is an instance of Text
  static bool isText(dynamic node) {
    print('isText: ${node['nodeType']}');
    return node['nodeType'] == 'text';
  }
}
