import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final dynamic node;
  final Next next;
  final Options? options;

  Paragraph(this.node, this.next, this.options);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: options?.defaultStyle,
      textAlign: options?.textAlign,
      TextSpan(
        children: [
          TextSpan(
            children: next(node['content']),
          ),
        ],
      ),
    );
  }
}
