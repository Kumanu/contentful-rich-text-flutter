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
class ContentFulRichText {
  RenderNode defaultNodeRenderers = RenderNode({
    BLOCKS.PARAGRAPH.value: (node, next) => RichText(
          text: TextSpan(text: node.value, children: next(node.content)),
        ),
    BLOCKS.HEADING_1.value: (node, next) => Heading(level: BLOCKS.HEADING_1, text: node.value, content: node.content),
    BLOCKS.HEADING_2.value: (node, next) => Heading(level: BLOCKS.HEADING_2, text: node.value, content: node.content),
    BLOCKS.HEADING_3.value: (node, next) => Heading(level: BLOCKS.HEADING_3, text: node.value, content: node.content),
    BLOCKS.HEADING_4.value: (node, next) => Heading(level: BLOCKS.HEADING_4, text: node.value, content: node.content),
    BLOCKS.HEADING_5.value: (node, next) => Heading(level: BLOCKS.HEADING_5, text: node.value, content: node.content),
    BLOCKS.HEADING_6.value: (node, next) => Heading(level: BLOCKS.HEADING_6, text: node.value, content: node.content),
    BLOCKS.EMBEDDED_ENTRY.value: (node, next) => Container(), // TODO: implement
    BLOCKS.UL_LIST.value: (node, next) => UnorderedList(node.content),
    BLOCKS.OL_LIST.value: (node, next) => OrderedList(node.content),
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
    MARKS.BOLD.value: (text) => TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.bold)),
    MARKS.ITALIC.value: (text) => TextSpan(text: text, style: TextStyle(fontStyle: FontStyle.italic)),
    MARKS.UNDERLINE.value: (text) => TextSpan(text: text, style: TextStyle(decoration: TextDecoration.underline)),
    MARKS.CODE.value: (text) => TextSpan(text: text, style: TextStyle(decoration: TextDecoration.underline)),
  });

  static Widget defaultInline(INLINES type, Inline node) => Container(); // TODO: implement

  Document richTextDocument;
  Options options;

  ContentFulRichText(this.richTextDocument, {this.options});

  Widget get documentToWidgetTree {
    if (richTextDocument == null || richTextDocument.content == null) {
      return Container();
    }

    Map<dynamic, Function> renderNode = Map.from(defaultNodeRenderers.renderNodes);
    renderNode.addAll(options?.renderNode?.renderNodes);
    Map<dynamic, Function> renderMark = Map.from(defaultMarkRenderers.renderMarks);
    renderMark.addAll(options?.renderMark?.renderMarks);

    return nodeListToWidget(
      richTextDocument.content,
      renderNode: renderNode,
      renderMark: renderMark,
    );
  }

  Widget nodeListToWidget(
    List<TopLevelBlock> nodes, {
    Map<dynamic, Function> renderNode,
    Map<dynamic, Function> renderMark,
  }) {
    return Column(
      children: nodes.map<Widget>(
        (TopLevelBlock node) => nodeToWidget(node, renderNode: renderNode, renderMark: renderMark),
      ),
    );
  }

  Widget nodeToWidget(
    TopLevelBlock node, {
    Map<dynamic, Function> renderNode,
    Map<dynamic, Function> renderMark,
  }) {
    if (Helpers.isText(node)) {
      TextNode textNode = node as TextNode;
      String nodeValue = HtmlUnescape().convert(textNode.value);
      if (textNode.marks.length > 0) {
        return RichText(
          text: TextSpan(
            children: textNode.marks.map<TextSpan>(
              (Mark mark) => renderMark[mark.type](textNode.value),
            ),
          ),
        );
      }
      return Text(nodeValue);
    } else {
      Next nextNode = (nodes) => nodeListToWidget(
            nodes,
            renderNode: renderNode,
            renderMark: renderMark,
          );
      if (node.nodeType == null || renderNode[node.nodeType] == null) {
        // TODO: Figure what to return when passed an unrecognized node.
        return Container();
      }
      return renderNode[node.nodeType](node, nextNode);
    }
  }
}
