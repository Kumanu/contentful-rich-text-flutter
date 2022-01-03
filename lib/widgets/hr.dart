import 'package:flutter/material.dart';

class Hr extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets padding;

  Hr({
    this.color = Colors.black,
    this.height = 1.0,
    this.padding = const EdgeInsets.only(
      top: 10.0,
      left: 0.0,
      right: 0.0,
      bottom: 10.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        color: color,
        height: height,
      ),
    );
  }
}
