library contentful_rich_text;

import 'package:contentful_rich_text/state/renderers.dart';
import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/helpers.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/marks.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:contentful_rich_text/widgets/heading.dart';
import 'package:contentful_rich_text/widgets/hr.dart';
import 'package:contentful_rich_text/widgets/hyperlink.dart';
import 'package:contentful_rich_text/widgets/inline_embedded_entry.dart';
import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:contentful_rich_text/widgets/ordered_list.dart';
import 'package:contentful_rich_text/widgets/paragraph.dart';
import 'package:contentful_rich_text/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';

/// Contentful Rich Text widget
class ContentfulRichText {
  ContentfulRichText(this.richTextJson, {required this.options});

  dynamic richTextJson;
  Options options;
  Document? richTextDocument;

  // TODO: implement
  static Widget _defaultInline(INLINES type, Inline node) => Container();

  RenderNode defaultNodeRenderers() => RenderNode({
        BLOCKS.PARAGRAPH.value: (node, next) => Paragraph(
              node,
              next,
              options,
            ),
        BLOCKS.HEADING_1.value: (node, next) => Heading(
              level: BLOCKS.HEADING_1,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              options: options,
              next: next,
            ),
        BLOCKS.HEADING_2.value: (node, next) => Heading(
              level: BLOCKS.HEADING_2,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              options: options,
              next: next,
            ),
        BLOCKS.HEADING_3.value: (node, next) => Heading(
              level: BLOCKS.HEADING_3,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              next: next,
            ),
        BLOCKS.HEADING_4.value: (node, next) => Heading(
              level: BLOCKS.HEADING_4,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              next: next,
            ),
        BLOCKS.HEADING_5.value: (node, next) => Heading(
              level: BLOCKS.HEADING_5,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              next: next,
            ),
        BLOCKS.HEADING_6.value: (node, next) => Heading(
              level: BLOCKS.HEADING_6,
              text: node['value'] ?? '',
              content: node['content'] ?? '',
              next: next,
            ),
        BLOCKS.EMBEDDED_ENTRY.value: (node, next) =>
            Container(), // TODO: implement
        BLOCKS.UL_LIST.value: (node, next) =>
            UnorderedList(node['content'] ?? '', next),
        BLOCKS.OL_LIST.value: (node, next) =>
            OrderedList(node['content'] ?? '', next),
        BLOCKS.LIST_ITEM.value: (node, next) => ListItem(
              text: node.value,
              type: node.nodeType == BLOCKS.OL_LIST.value
                  ? ListItemType.ordered
                  : ListItemType.unordered,
              children: node['content'] ?? '',
            ),
        BLOCKS.QUOTE.value: (node, next) => Container(), // TODO: implement
        BLOCKS.HR.value: (node, next) => Hr(),
        INLINES.ASSET_HYPERLINK.value: (node, next) =>
            _defaultInline(INLINES.ASSET_HYPERLINK, node as Inline),
        INLINES.ENTRY_HYPERLINK.value: (node, next) =>
            _defaultInline(INLINES.ENTRY_HYPERLINK, node as Inline),
        INLINES.EMBEDDED_ENTRY.value: (node, next) =>
            InlineEmbeddedEntry(node, next),
        INLINES.HYPERLINK.value: (node, next) => Hyperlink(node, next),
      });

  /// This is the main entry point for ContentfulRichText. To render
  /// Flutter widgets, in your app instantiate ContentfulRichText with
  /// the JSON data, as well as any (optional) Renderer or Mark options,
  /// and then get documentToWidgetTree:
  /// ContentfulRichText(json, options: {...}).documentToWidgetTree
  Widget get documentToWidgetTree {
    if (richTextJson != null && richTextJson['content'] != null) {
      // parse richTextData to a Document from JSON form
      richTextDocument = _parseRichTextJson();

      singletonRenderers.renderNode = Map.from(
        defaultNodeRenderers().renderNodes,
      );
      singletonRenderers.renderNode.addAll(options.renderNode.renderNodes);
      singletonRenderers.renderMark = MARKS.renderMarks(
        options.renderMark?.renderMarks,
      );

      singletonRenderers.defaultStyle = options.defaultStyle;

      return Container(
        child: nodeListToWidget(richTextDocument?.content ?? []),
      );
    }
    return Container();
  }

  /// nodeListToWidget renders the Widget tree from the data nodes
  Widget nodeListToWidget(List<dynamic>? nodes) {
    return Column(
      mainAxisAlignment: options.mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nodes?.map<Widget>((node) => nodeToWidget(node)).toList() ?? [],
    );
  }

  /// nodeToWidget handles converting a node into a Widget, as well as handling
  /// any custom logic needed to accommodate different node types
  Widget nodeToWidget(dynamic node) {
    if (Helpers.isText(node)) {
      return Text.rich(
        textAlign: options.textAlign,
        TextSpan(text: _processInlineNode(node)),
      );
    } else if (Helpers.isParagraph(node) || Helpers.isHeader(node)) {
      // TODO: Headers don't appear to set their size properly
      return singletonRenderers.renderNode[node['nodeType']]!(
        node,
        (nodes) => List<TextSpan>.from(
          nodes.map(
            (node) => _processInlineNode(node),
          ),
        ),
      );
    } else {
      nextNode(nodes) => nodeListToWidget(nodes);
      if (node['nodeType'] == null ||
          singletonRenderers.renderNode[node['nodeType']] == null) {
        // TODO: Figure what to return when passed an unrecognized node.
        return Container();
      }
      return singletonRenderers.renderNode[node['nodeType']]!(node, nextNode);
    }
  }

  /// _processInlineNode handle converting nodes into (potentially
  /// nested) TextSpans, typically coming from Paragraph, Heading and
  /// Hyperlink nodes
  dynamic _processInlineNode(
    node, {
    String? uri,
  }) {
    if (node['nodeType'] == 'hyperlink' || uri?.isNotEmpty == true) {
      // Note: Hyperlinks are nested in other blocs like Paragraphs/Headers
      String link = uri ?? node['data']['uri'];
      String nodeType = node['nodeType'] ?? '';
      if (uri?.isNotEmpty == true && node['nodeType'] == 'text') {
        // ensure Hyperlink is used for text blocks with uris
        nodeType = 'hyperlink';
        // pass uri for Hyperlink on text nodes for TapRecognizer
        node['data'] = {'uri': link};
      }
      return singletonRenderers.renderNode[nodeType]!(
        node,
        (nodes) =>
            nodes
                ?.map<TextSpan>(
                  (node) => _processInlineNode(
                    node,
                    uri: link,
                  ) as TextSpan,
                )
                ?.toList() ??
            <InlineSpan>[],
      );
    }

    // for links to entries only process the child-nodes
    if (node['nodeType'] == 'entry-hyperlink') {
      return TextSpan(
        children: (node['content'] ?? '')
            .map<TextSpan>((subNode) => _processInlineNode(subNode) as TextSpan)
            .toList(),
      );
    }

    if (node['nodeType'] == 'embedded-entry-inline') {
      return singletonRenderers.renderNode[node['nodeType']]!(
        node,
        (nodes) =>
            nodes
                ?.map<TextSpan>(
                  (node) => _processInlineNode(
                    node,
                  ) as TextSpan,
                )
                ?.toList() ??
            <InlineSpan>[],
      );
    }

    // If not a hyperlink, process as text node
    TextNode textNode = TextNode(node);
    String nodeValue = HtmlUnescape().convert(textNode.value);
    if (textNode.marks.isNotEmpty) {
      return TextSpan(
        text: nodeValue,
        style: MARKS.getMarksTextStyles(
          textNode.marks,
          singletonRenderers.renderMark,
          options.defaultStyle,
        ),
      );
    }
    return TextSpan(
      text: nodeValue,
      style: options.defaultStyle,
    );
  }

  Document? _parseRichTextJson() {
    if (richTextJson == null || richTextJson['nodeType'] != 'document') {
      return null;
    }
    return Document.fromJson(richTextJson);
  }
}
