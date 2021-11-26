import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';
import 'package:flutter/widgets.dart';

abstract class Node<T> {
  late T _nodeType;
  Map<dynamic, dynamic>? data;
  T get nodeType => _nodeType;
}

abstract class Block<T> extends Node<BLOCKS> {
  late BLOCKS _nodeType;
  List<T>? content;
}

abstract class Inline<T> extends Node<INLINES> {
  late INLINES _nodeType;
  List<T>? content;
}

abstract class TopLevelBlock extends Node<TopLevelBlockEnum> {
  late TopLevelBlockEnum _nodeType;
}

class Document extends Node<BLOCKS> {
  BLOCKS _nodeType = BLOCKS.DOCUMENT;
  List<dynamic> content;

  Document({
    required this.content,
    required String nodeType,
    required Map<dynamic, dynamic> data,
  }) {
    this._nodeType = BLOCKS.fromValue(nodeType);
    this.data = data;
  }

  static Document? fromJson(dynamic richTextJson) {
    if (richTextJson == null) {
      return null;
    }
    return Document(
      content: richTextJson['content'],
      nodeType: richTextJson['nodeType'],
      data: richTextJson['data'],
    );
  }
}

class TextNode extends Node<String> {
  String _nodeType = 'text';
  String value = '';
  List<Mark> marks = [];

  TextNode(dynamic node) {
    value = node['value'] ?? '';
    _nodeType = node['nodeType'] ?? '';
    List<dynamic> markList = node['marks'] ?? [];
    // Adding types to marks
    if (markList.isNotEmpty) {
      var typeList = markList.map((e) => e['type']).toList();
      for (var i = 0; i < typeList.length; i++) {
        marks.add(Mark(typeList[i]));
      }
    }
  }
}

class Mark {
  String type;

  Mark(this.type);
}

// Helper types for Rich Text Rendering
typedef Next = dynamic Function(dynamic nodes);
typedef NodeRenderer = dynamic Function(dynamic node, Next next);

class RenderNode<T> {
  Map<T, NodeRenderer> renderNodes; // NodeRenderer not Function
  RenderNode(this.renderNodes);
}

class RenderMark<T> {
  Map<T, TextStyle> renderMarks;
  RenderMark(this.renderMarks);
}

class Options {
  /// Node renderers
  RenderNode renderNode;

  /// Mark renderers
  RenderMark? renderMark;

  Options({required this.renderNode, this.renderMark});
}
