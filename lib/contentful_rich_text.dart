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

  // Can only be used to apply styling, does not return a TextSpan
  RenderMark defaultMarkRenderers = RenderMark({
    MARKS.BOLD.value: TextStyle(fontWeight: FontWeight.bold),
    MARKS.ITALIC.value: TextStyle(fontStyle: FontStyle.italic),
    MARKS.UNDERLINE.value: TextStyle(decoration: TextDecoration.underline),
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
    Map<dynamic, TextStyle> renderMark = Map.from(defaultMarkRenderers.renderMarks);
    renderMark.addAll(options?.renderMark?.renderMarks ?? Map<dynamic, TextStyle>());

    return Container(
      child: nodeListToWidget(
        richTextDocument.content,
        renderNode: renderNode,
        renderMark: renderMark,
      ),
    );
  }

  Widget nodeListToWidget(List<dynamic> nodes,
      {Map<dynamic, Function> renderNode, Map<dynamic, TextStyle> renderMark}) {
    print('nodeListToWidget ${nodes.length}');
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
    Map<dynamic, TextStyle> renderMark,
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

  TextSpan _processTextNode(node, Map<dynamic, TextStyle> renderMark) {
    print('nodeToWidget text');
    TextNode textNode = TextNode(node);
    String nodeValue = HtmlUnescape().convert(textNode.value);
    if (textNode.marks != null && textNode.marks.length > 0) {
      print('TextNode has marks: ${textNode.value}, ${textNode.marks}');
      TextStyle textStyle = _getMarksTextStyles(textNode.marks, renderMark);
      return TextSpan(
        text: nodeValue,
        style: textStyle.apply(
          color: Colors.black,
        ),
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

  TextStyle _getMarksTextStyles(List<Mark> marks, Map<dynamic, TextStyle> renderMark) {
    Map<String, TextStyle> textStyles = {};
    marks.forEach((Mark mark) {
      print('${mark.type}, ${renderMark[mark.type]}');
      textStyles.putIfAbsent(mark.type, () => renderMark[mark.type]);
    });
    return TextStyle(
      fontWeight: textStyles['bold']?.fontWeight,
      fontStyle: textStyles['italic']?.fontStyle,
      decoration: textStyles['underline']?.decoration,
    );
  }

  Document _parseRichTextJson() {
    if (richTextJson == null || richTextJson['nodeType'] != 'document') {
      return null;
    }
    return Document.fromJson(richTextJson);
  }
}
