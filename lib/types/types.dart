import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';
import 'package:flutter/widgets.dart';

abstract class Node<T> {
  T _nodeType;
  Map<dynamic, dynamic> data;
  T get nodeType => _nodeType;
}

abstract class Block<T> extends Node<BLOCKS> {
  BLOCKS _nodeType;
  List<T> content;
}

abstract class Inline<T> extends Node<INLINES> {
  INLINES _nodeType;
  List<T> content;
}

abstract class TopLevelBlock extends Node<TopLevelBlockEnum> {
  TopLevelBlockEnum _nodeType;
}

class Document extends Node<BLOCKS> {
  BLOCKS _nodeType = BLOCKS.DOCUMENT;
  List<dynamic> content;

  Document({this.content, String nodeType, Map<dynamic, dynamic> data}) {
    this._nodeType = BLOCKS.fromValue(nodeType);
    this.data = data;
  }

  factory Document.fromJson(dynamic richTextJson) {
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
  String value;
  List<Mark> marks;

  TextNode(dynamic node) {
    this.value = node['value'];
    this._nodeType = node['nodeType'];
    List<Mark> _marks = List<Mark>();
    node['marks']?.forEach((mark) {
      _marks.add(Mark(mark['type']));
    });
    this.marks = _marks;
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
  RenderMark renderMark;

  Options({this.renderNode, this.renderMark});
}
