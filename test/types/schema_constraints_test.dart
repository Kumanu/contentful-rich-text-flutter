import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/types/schema_constraints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get block by index with [] operator', () {
    // Good request
    expect(TopLevelBlockEnum.HEADING_2[2], TopLevelBlockEnum.HEADING_2);
    // Bad request
    expect(TopLevelBlockEnum.HEADING_2[200], isNull);
  });

  test('should get block by key with [] operator', () {
    // Good request
    expect(
        TopLevelBlockEnum.HEADING_2['HEADING_1'], TopLevelBlockEnum.HEADING_1);
    // Bad request
    expect(TopLevelBlockEnum.HEADING_2['MISSING'], isNull);
  });

  test('should get block by float with [] operator', () {
    // Bad request
    expect(TopLevelBlockEnum.HEADING_2[0.1], isNull);
  });

  test('should get block fromKey', () {
    // Good request
    expect(TopLevelBlockEnum.fromKey('HEADING_2'), TopLevelBlockEnum.HEADING_2);
    // Bad request
    expect(TopLevelBlockEnum.fromKey('NOPE'), isNull);
  });

  test('should get block fromValue', () {
    // Good request
    expect(TopLevelBlockEnum.fromValue(BLOCKS.HEADING_1),
        TopLevelBlockEnum.HEADING_1);
    // Bad request
    expect(TopLevelBlockEnum.fromValue(BLOCKS.HEADING_3), isNull);
  });

  test('should print', () {
    expect(
        TopLevelBlockEnum.PARAGRAPH.toString(), 'TopLevelBlockEnum.PARAGRAPH');
  });
}
