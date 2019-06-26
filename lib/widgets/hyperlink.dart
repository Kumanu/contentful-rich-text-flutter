import 'package:contentful_rich_text/state/renderers.dart';
import 'package:contentful_rich_text/types/marks.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends TextSpan {
  Hyperlink(node, next)
      : assert(node['data'] != null),
        assert(node['data']['uri'] != null), // ensure uri exists for hyperlink
        assert(node['data']['uri'] != ''),
        super(
          text: node['value'],
          style: MARKS
              .getMarksTextStyles(
                TextNode(node).marks,
                singletonRenderers.renderMark,
              )
              .copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
          children: next(node['content']),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              String uri = node['data']['uri'];
              // NOTE: Defaults to Url_Launcher, but component can be overridden
              if (await canLaunch(uri)) {
                await launch(uri);
              }
            },
        );
}
