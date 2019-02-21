import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final double indent;
  final List<String> children;

  UnorderedList(this.children, {this.indent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.map<Widget>((text) => ListItem.unordered(text: text)),
    );
  }
}
