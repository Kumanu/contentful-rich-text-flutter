library contentful_rich_text;

import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/helpers.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/marks.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:contentful_rich_text/widgets/heading.dart';
import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:contentful_rich_text/widgets/ordered_list.dart';
import 'package:contentful_rich_text/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';

/// Contentful Rich Text widget
class ContentfulRichText {
  RenderNode defaultNodeRenderers = RenderNode({
    BLOCKS.PARAGRAPH.value: (node, next) => RichText(
          text: TextSpan(
            children: next(node['content']),
          ),
        ),
    BLOCKS.HEADING_1.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_1, text: node['value'], content: node['content']),
    BLOCKS.HEADING_2.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_2, text: node['value'], content: node['content']),
    BLOCKS.HEADING_3.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_3, text: node['value'], content: node['content']),
    BLOCKS.HEADING_4.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_4, text: node['value'], content: node['content']),
    BLOCKS.HEADING_5.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_5, text: node['value'], content: node['content']),
    BLOCKS.HEADING_6.value: (node, next) =>
        Heading(level: BLOCKS.HEADING_6, text: node['value'], content: node['content']),
    BLOCKS.EMBEDDED_ENTRY.value: (node, next) => Container(), // TODO: implement
    BLOCKS.UL_LIST.value: (node, next) => UnorderedList(node['content']),
    BLOCKS.OL_LIST.value: (node, next) => OrderedList(node['content']),
    BLOCKS.LIST_ITEM.value: (node, next) => ListItem(
          text: node.value,
          // TODO: not sure we can use nodeType to determine the type of LIST_ITEM
          type: node.nodeType == BLOCKS.OL_LIST.value ? LI_TYPE.ORDERED : LI_TYPE.UNORDERED,
        ),
    BLOCKS.QUOTE.value: (node, next) => Container(), // TODO: implement
    BLOCKS.HR.value: (node, next) => Container(), // TODO: implement
    INLINES.ASSET_HYPERLINK.value: (node, next) => defaultInline(INLINES.ASSET_HYPERLINK, node as Inline),
    INLINES.ENTRY_HYPERLINK.value: (node, next) => defaultInline(INLINES.ENTRY_HYPERLINK, node as Inline),
    INLINES.EMBEDDED_ENTRY.value: (node, next) => defaultInline(INLINES.EMBEDDED_ENTRY, node as Inline),
    INLINES.HYPERLINK.value: (node, next) => Container(), // TODO: implement
  });

  RenderMark defaultMarkRenderers = RenderMark({
    MARKS.BOLD.value: (text) => TextSpan(
          text: text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
    MARKS.ITALIC.value: (text) => TextSpan(
          text: text,
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
        ),
    MARKS.UNDERLINE.value: (text) => TextSpan(
          text: text,
          style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
        ),
    MARKS.CODE.value: (text) => TextSpan(
          text: text,
          style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
        ),
  });

  static Widget defaultInline(INLINES type, Inline node) => Container(); // TODO: implement

  dynamic richTextJson;
  Options options;
  Document richTextDocument;

  ContentfulRichText(this.richTextJson, {this.options});

  Widget get documentToWidgetTree {
    if (richTextJson == null || richTextJson['content'] == null) {
      return Container();
    }

    // parse richTextData to a Document from JSON form
    richTextDocument = _parseRichTextJson();

    Map<dynamic, Function> renderNode = Map.from(defaultNodeRenderers.renderNodes);
    renderNode.addAll(options?.renderNode?.renderNodes ?? Map<dynamic, Function>());
    Map<dynamic, Function> renderMark = Map.from(defaultMarkRenderers.renderMarks);
    renderMark.addAll(options?.renderMark?.renderMarks ?? Map<dynamic, Function>());

    return Container(
      child: nodeListToWidget(
        richTextDocument.content,
        renderNode: renderNode,
        renderMark: renderMark,
      ),
    );
  }

  Widget nodeListToWidget(
    List<dynamic> nodes, {
    Map<dynamic, Function> renderNode,
    Map<dynamic, Function> renderMark,
    bool isParagraph = false,
  }) {
    print('nodeListToWidget ${nodes.length}');
    if (isParagraph) {
      return RichText(
        text: TextSpan(
          children: List<TextSpan>.from(
            nodes.map<TextSpan>(
              (dynamic node) => _processTextNode(node, renderMark),
            ),
          ),
        ),
      );
    }
    return Column(
      children: List<Widget>.from(
        nodes.map<Widget>((dynamic node) => nodeToWidget(
              node,
              renderNode: renderNode,
              renderMark: renderMark,
            )),
      ),
    );
  }

  Widget nodeToWidget(
    dynamic node, {
    Map<dynamic, Function> renderNode,
    Map<dynamic, Function> renderMark,
  }) {
    print('nodeToWidget entry $node');
    if (Helpers.isText(node)) {
      return RichText(text: _processTextNode(node, renderMark));
    } else if (Helpers.isParagraph(node)) {
      print('we have a paragraph');
      return renderNode[node['nodeType']](
        node,
        (nodes) => List<TextSpan>.from(nodes.map((node) => _processTextNode(node, renderMark))),
      );
    } else {
      print('nodeToWidget not text');
      Next nextNode = (nodes) => nodeListToWidget(
            nodes,
            renderNode: renderNode,
            renderMark: renderMark,
          );
      if (node['nodeType'] == null || renderNode[node['nodeType']] == null) {
        print('unrecognized node: ${node['nodeType']}');
        // TODO: Figure what to return when passed an unrecognized node.
        return Container();
      }
      return renderNode[node['nodeType']](node, nextNode);
    }
  }

  TextSpan _processTextNode(node, Map<dynamic, Function> renderMark) {
    print('nodeToWidget text');
    TextNode textNode = TextNode(node);
    String nodeValue = HtmlUnescape().convert(textNode.value);
    if (textNode.marks != null && textNode.marks.length > 0) {
      print('TextNode has marks: ${textNode.value}, ${textNode.marks}');
      List<TextSpan> _textSpans = List<TextSpan>();
      textNode.marks.forEach((mark) {
        // TODO: Currently prints the value once for each Mark instead
        // of wrapping the marks around the value and applying all of them to
        // the single content value
        print('TextNode Mark: ${mark.type}');
        if (mark.type != null) {
          _textSpans.add(renderMark[mark.type](textNode.value));
        }
      });
      return TextSpan(
        style: TextStyle(
          color: Colors.black,
        ),
        children: _textSpans,
      );
    }
    print('TextNode no marks: ${textNode.value}');
    return TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: nodeValue,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Document _parseRichTextJson() {
    if (richTextJson == null || richTextJson['nodeType'] != 'document') {
      return null;
    }
    return Document.fromJson(richTextJson);
  }
}
