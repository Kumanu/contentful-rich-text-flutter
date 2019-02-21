import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';
import 'package:contentful_rich_text/types/types.dart';

class Helpers {
  /// Checks if the node is an instance of Inline
  static bool isInline(Node node) {
    return INLINES.values.contains(node.nodeType);
  }

  /// Checks if the node is an instance of Block
  static bool isBlock(Node node) {
    return BLOCKS.values.contains(node.nodeType);
  }

  /// Checks if the node is an instance of TopLevelBlocks
  static bool isTopLevelBlock(Node node) {
    return TopLevelBlockEnum.values.contains(node.nodeType);
  }

  /// Checks if the node is an instance of Text
  static bool isText(Node node) {
    return node.nodeType == 'text';
  }
}
