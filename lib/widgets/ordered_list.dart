import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class OrderedList extends StatelessWidget {
  final double indent;
  final String punctuation;

  /// index character, text for item
  final Map<String, String> children;

  OrderedList(this.children, {this.indent, this.punctuation = '.'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.keys.map<Widget>(
        (childKey) => ListItem.ordered(index: children[childKey][0], text: children[childKey][1]),
      ),
    );
  }
}
