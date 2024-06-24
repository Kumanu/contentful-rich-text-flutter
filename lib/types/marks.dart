import 'package:collection/collection.dart' show IterableExtension;
import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

/// Map of all Contentful marks
class MARKS {
  final String _key;
  final String _value;
  const MARKS._internal(this._key, this._value);

  @override
  String toString() => 'MARKS.$_key';
  String get key => _key;
  String get value => _value;
  operator [](dynamic index) => index is int
      ? items[index]
      : index is String
          ? items.firstWhereOrNull((item) => item.key == index)
          : null;

  static const BOLD = const MARKS._internal('BOLD', 'bold');
  static const ITALIC = const MARKS._internal('ITALIC', 'italic');
  static const UNDERLINE = const MARKS._internal('UNDERLINE', 'underline');

  // Helpers
  static List<MARKS> get items => [
        BOLD,
        ITALIC,
        UNDERLINE,
      ];
  static fromKey(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  static fromValue(String value) {
    return items.firstWhereOrNull((item) => item.value == value);
  }

  // Can only be used to apply styling, does not return a TextSpan
  static RenderMark defaultMarkRenderers = RenderMark({
    MARKS.BOLD.value: TextStyle(fontWeight: FontWeight.bold),
    MARKS.ITALIC.value: TextStyle(fontStyle: FontStyle.italic),
    MARKS.UNDERLINE.value: TextStyle(decoration: TextDecoration.underline),
  });

static TextStyle getMarksTextStyles(List<Mark> marks, Map<dynamic, TextStyle> renderMark) {
  TextStyle combinedStyle = TextStyle();
  TextStyle combinedTypeStyle = TextStyle();

  marks.forEach((Mark mark) {
    if (renderMark.containsKey(mark.type)) {
      TextStyle markStyle = renderMark[mark.type]!;
      combinedStyle = combinedStyle.merge(markStyle);
      combinedTypeStyle = combinedTypeStyle.copyWith(
        fontWeight: mark.type == 'bold' ? markStyle.fontWeight : combinedTypeStyle.fontWeight,
        fontStyle: mark.type == 'italic' ? markStyle.fontStyle : combinedTypeStyle.fontStyle,
        decoration: mark.type == 'underline' ? markStyle.decoration : combinedTypeStyle.decoration,
      );
    }
  });

  return combinedTypeStyle.merge(combinedStyle);
}



  static Map<dynamic, TextStyle> renderMarks(
          Map<dynamic, TextStyle>? optionRenderMarks) =>
      optionRenderMarks == null
          ? Map.from(MARKS.defaultMarkRenderers.renderMarks)
          : (Map.from(MARKS.defaultMarkRenderers.renderMarks)
            ..addAll(optionRenderMarks));
}
