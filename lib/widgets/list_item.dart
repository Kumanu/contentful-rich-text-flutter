import 'package:contentful_rich_text/widgets/bullet.dart';
import 'package:flutter/material.dart';

enum LI_TYPE { UNORDERED, ORDERED }

class ListItem extends StatelessWidget {
  final LI_TYPE type;
  final double indent;
  final String text;
  final String punctuation;
  final String index;

  ListItem({
    @required this.type,
    @required this.text,
    this.indent,
    this.index,
    this.punctuation,
  });

  ListItem.unordered({
    this.type = LI_TYPE.UNORDERED,
    @required this.text,
    this.indent,
    this.index,
    this.punctuation,
  });

  ListItem.ordered({
    this.type = LI_TYPE.ORDERED,
    @required this.text,
    @required this.index,
    this.punctuation = '.',
    this.indent,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LI_TYPE.UNORDERED:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              width: indent ?? 24.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Bullet(
                  style: TextStyle(
                    // TODO: remove color styles after defaults are figured out
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: Text(
                text,
                style: TextStyle(
                  // TODO: remove color styles after defaults are figured out
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      case LI_TYPE.ORDERED:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              width: indent ?? 24.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 3.0, left: 6.0),
                child: Text(
                  '$index$punctuation',
                  style: TextStyle(
                    // TODO: remove color styles after defaults are figured out
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: Text(
                text,
                style: TextStyle(
                  // TODO: remove color styles after defaults are figured out
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
    }
    return Container();
  }
}
