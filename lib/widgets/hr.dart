import 'package:flutter/material.dart';

class Hr extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets padding;

  Hr({
    this.color,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            top: 10.0,
            left: 0.0,
            right: 0.0,
            bottom: 10.0,
          ),
      child: Container(
        color: color ?? Colors.black,
        height: height ?? 1.0,
      ),
    );
  }
}
