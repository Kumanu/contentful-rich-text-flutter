import 'package:contentful_rich_text/widgets/list_item.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final double indent;
  final List<Map<String, String>> children;

  UnorderedList(this.children, {this.indent});

  @override
  Widget build(BuildContext context) {
    print('UnorderedList Children: ${this.children}');
    List<Widget> listItems = [];
    children.forEach((child) {
      print(child);
      listItems.add(ListItem.unordered(text: child['value']));
    });
    return Column(
      children: listItems,
    );
  }
}
