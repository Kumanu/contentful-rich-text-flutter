import 'package:contentful_rich_text/state/renderers.dart';
import 'package:contentful_rich_text/types/marks.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

class InlineEmbeddedEntry extends TextSpan {
  InlineEmbeddedEntry(node, next)
      : super(
          text: node['value'],
          style: MARKS
              .getMarksTextStyles(
                TextNode(node).marks,
                singletonRenderers.renderMark,
                singletonRenderers.defaultStyle,
              )
              // TODO: Check if only marks should be used instead of these hard coded values
              .copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
          children: next(node['content']),
        );
}
