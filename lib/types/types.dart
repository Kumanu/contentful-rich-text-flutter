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
  final BLOCKS _nodeType;
  final List<dynamic> content;

  Document({
    required this.content,
    required String nodeType,
    required Map<dynamic, dynamic> data,
  }) : _nodeType = BLOCKS.fromValue(nodeType) ?? BLOCKS.DOCUMENT {
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
  final String _nodeType;
  final String value;
  final List<Mark> marks;

  TextNode(dynamic node)
      : value = node['value'] ?? '',
        _nodeType = node['nodeType'] ?? '',
        marks = (node['marks'] as List?)
                ?.map((mark) => Mark(mark['type']))
                .toList() ??
            <Mark>[];
}

class Mark {
  final String type;

  Mark(this.type);
}

// Helper types for Rich Text Rendering
typedef Next = dynamic Function(dynamic nodes);
typedef NodeRenderer = dynamic Function(dynamic node, Next next);

class RenderNode<T> {
  final Map<T, NodeRenderer> renderNodes; // NodeRenderer not Function
  RenderNode(this.renderNodes);
}

class RenderMark<T> {
  final Map<T, TextStyle> renderMarks;
  RenderMark(this.renderMarks);
}

class Options {
  Options({
    required this.renderNode,
    this.renderMark,
    required this.defaultStyle,
    this.textAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  /// Node renderers
  RenderNode renderNode;

  /// Mark renderers
  RenderMark? renderMark;

  /// Default Style
  TextStyle defaultStyle;

  /// Text Align
  TextAlign textAlign;

  /// Main Axis Alignment
  MainAxisAlignment mainAxisAlignment;
}
