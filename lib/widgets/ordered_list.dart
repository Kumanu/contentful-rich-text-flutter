import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class OrderedList extends StatelessWidget {
  final double indent;
  final String punctuation;

  /// index character, text for item
  final List<Map<String, String>> children;

  OrderedList(this.children, {this.indent, this.punctuation = '.'});

  @override
  Widget build(BuildContext context) {
    print('OrderedList Children: ${this.children}');
    List<Widget> listItems = [];
    children.forEach((child) {
      print('$child: ${this.children.indexOf(child)}');
      listItems.add(
        ListItem.ordered(
          text: child['value'],
          index: (this.children.indexOf(child) + 1).toString(),
        ),
      );
    });
    return Column(
      children: listItems,
    );
  }
}
