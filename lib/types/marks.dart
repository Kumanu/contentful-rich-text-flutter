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
          ? items.firstWhere((item) => item.key == index, orElse: () => null)
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
    return items.firstWhere((item) => item.key == key, orElse: () => null);
  }

  static fromValue(String value) {
    return items.firstWhere((item) => item.value == value, orElse: () => null);
  }

  // Can only be used to apply styling, does not return a TextSpan
  static RenderMark defaultMarkRenderers = RenderMark({
    MARKS.BOLD.value: TextStyle(fontWeight: FontWeight.bold),
    MARKS.ITALIC.value: TextStyle(fontStyle: FontStyle.italic),
    MARKS.UNDERLINE.value: TextStyle(decoration: TextDecoration.underline),
  });

  static TextStyle getMarksTextStyles(
      List<Mark> marks, Map<dynamic, TextStyle> renderMark) {
    Map<String, TextStyle> textStyles = {};
    marks.forEach((Mark mark) {
      textStyles.putIfAbsent(mark.type, () => renderMark[mark.type]);
    });
    return TextStyle(
      fontWeight: textStyles['bold']?.fontWeight,
      fontStyle: textStyles['italic']?.fontStyle,
      decoration: textStyles['underline']?.decoration,
    );
  }

  static Map<dynamic, TextStyle> renderMarks(
          Map<dynamic, TextStyle> optionRenderMarks) =>
      optionRenderMarks == null
          ? Map.from(MARKS.defaultMarkRenderers.renderMarks)
          : (Map.from(MARKS.defaultMarkRenderers.renderMarks)
            ..addAll(optionRenderMarks));
}
