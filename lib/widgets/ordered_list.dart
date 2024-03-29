import 'package:contentful_rich_text/types/types.dart';
import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class OrderedList extends StatelessWidget {
  final double? indent;
  final String punctuation;
  final Next next;

  /// index character, text for item
  final List<dynamic> children;

  OrderedList(this.children, this.next, {this.indent, this.punctuation = '.'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
          .asMap()
          .entries
          .map(
            (entry) => ListItem.ordered(
              text: entry.value['value'],
              index: (entry.key + 1).toString(),
              children: <Widget>[
                next(entry.value['content'])
              ], // TODO: Implement nested lists
            ),
          )
          .toList(),
    );
  }
}
