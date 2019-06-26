import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final dynamic node;
  final Next next;

  Paragraph(this.node, this.next);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
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
