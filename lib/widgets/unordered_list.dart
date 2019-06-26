import 'package:contentful_rich_text/types/types.dart';
import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final double indent;
  final List<dynamic> children;
  final Next next;

  UnorderedList(this.children, this.next, {this.indent});

  @override
  Widget build(BuildContext context) {
    List<Widget> listItems = [];
    children.forEach((child) {
      listItems.add(
        ListItem.unordered(
          text: child['value'],
          children: <Widget>[
            next(child['content'])
          ], // TODO: Implement nested lists
        ),
      );
    });
    return Column(
      children: listItems,
    );
  }
}
