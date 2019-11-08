import 'package:contentful_rich_text/widgets/bullet.dart';
import 'package:flutter/material.dart';

enum LI_TYPE { UNORDERED, ORDERED }

class ListItem extends StatelessWidget {
  final LI_TYPE type;
  final double indent;
  final String text;
  final String punctuation;
  final String index;
  final List<Widget> children;

  ListItem({
    @required this.type,
    @required this.text,
    this.index,
    this.indent,
    this.punctuation,
    this.children,
  });

  ListItem.unordered({
    this.type = LI_TYPE.UNORDERED,
    @required this.text,
    this.index,
    this.indent,
    this.punctuation,
    this.children,
  });

  ListItem.ordered({
    this.type = LI_TYPE.ORDERED,
    @required this.text,
    @required this.index,
    this.indent,
    this.punctuation = '.',
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LI_TYPE.UNORDERED:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: indent ?? 24.0,
              height: 20.0,
              child: Padding(
                padding: EdgeInsets.only(right: 1.0, left: 8.0),
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
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(text),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: this.children ?? [],
                    ),
            ),
          ],
        );
      case LI_TYPE.ORDERED:
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
                      child: Text(text),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: this.children ?? [],
                    ),
            ),
          ],
        );
    }
    return Container();
  }
}
