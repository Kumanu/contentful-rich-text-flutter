import 'package:contentful_rich_text/types/blocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get block by index with [] operator', () {
    // Good request
    expect(BLOCKS.DOCUMENT[2], BLOCKS.HEADING_1);
    // Bad request
    expect(BLOCKS.DOCUMENT[200], isNull);
  });

  test('should get block by key with [] operator', () {
    // Good request
    expect(BLOCKS.DOCUMENT['HEADING_1'], BLOCKS.HEADING_1);
    // Bad request
    expect(BLOCKS.DOCUMENT['MISSING'], isNull);
  });

  test('should get block by float with [] operator', () {
    // Bad request
    expect(BLOCKS.DOCUMENT[0.1], isNull);
  });

  test('should get block fromKey', () {
    // Good request
    expect(BLOCKS.fromKey('HEADING_2'), BLOCKS.HEADING_2);
    // Bad request
    expect(BLOCKS.fromKey('NOPE'), isNull);
  });

  test('should get block fromValue', () {
    // Good request
    expect(BLOCKS.fromValue('heading-3'), BLOCKS.HEADING_3);
    // Bad request
    expect(BLOCKS.fromValue('not-here'), isNull);
  });

  test('should print', () {
    expect(BLOCKS.HR.toString(), 'BLOCKS.HR');
  });
}
