import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

Map<BLOCKS, double> _defaultHeadingSizes = {
  BLOCKS.HEADING_1: 24.0,
  BLOCKS.HEADING_2: 22.0,
  BLOCKS.HEADING_3: 20.0,
  BLOCKS.HEADING_4: 18.0,
  BLOCKS.HEADING_5: 16.0,
  BLOCKS.HEADING_6: 14.0,
};

class Heading extends StatelessWidget {
  final BLOCKS level;
  final String text;
  final List<dynamic> content;
  final FontWeight fontWeight;
  final Next next;

  Heading({
    @required this.text,
    this.level = BLOCKS.HEADING_1,
    this.content,
    this.fontWeight = FontWeight.bold,
    this.next,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text ?? '',
            children: next(content),
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: _defaultHeadingSizes[level],
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
