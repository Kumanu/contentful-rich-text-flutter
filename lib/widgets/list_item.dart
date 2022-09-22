import 'package:contentful_rich_text/widgets/bullet.dart';
import 'package:flutter/material.dart';

enum ListItemType { unordered, ordered }

class ListItem extends StatelessWidget {
  final ListItemType? type;
  final double? indent;
  final String? text;
  final String? punctuation;
  final String? index;
  final List<Widget>? children;

  ListItem({
    required this.type,
    required this.text,
    this.index,
    this.indent,
    this.punctuation,
    this.children,
  });

  ListItem.unordered({
    this.type = ListItemType.unordered,
    required this.text,
    this.index,
    this.indent,
    this.punctuation,
    this.children,
  });

  ListItem.ordered({
    this.type = ListItemType.ordered,
    required this.text,
    required this.index,
    this.indent,
    this.punctuation = '.',
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ListItemType.unordered:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: indent ?? 24.0,
              height: 20.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 1.0, left: 8.0),
                child: Bullet(
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: text != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(text!),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: this.children ?? [],
                    ),
            ),
          ],
        );
      case ListItemType.ordered:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 7.0, top: 2.0, right: indent ?? 5),
              child: Text('$index$punctuation'),
            ),
            Expanded(
              child: text != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(text!),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: this.children ?? [],
                    ),
            ),
          ],
        );
      case null:
        return Container();
    }
  }
}
