import 'package:flutter/material.dart';

class Bullet extends Text {
  Bullet({
    String? bullet,
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          bullet ?? '•',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaler: TextScaler.linear(textScaleFactor ?? 1.0),
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
