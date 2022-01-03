import 'package:contentful_rich_text/types/inlines.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get block by index with [] operator', () {
    // Good request
    expect(INLINES.HYPERLINK[2], INLINES.ASSET_HYPERLINK);
    // Bad request
    expect(INLINES.HYPERLINK[200], isNull);
  });

  test('should get block by key with [] operator', () {
    // Good request
    expect(INLINES.HYPERLINK['EMBEDDED_ENTRY'], INLINES.EMBEDDED_ENTRY);
    // Bad request
    expect(INLINES.HYPERLINK['MISSING'], isNull);
  });

  test('should get block by float with [] operator', () {
    // Bad request
    expect(INLINES.HYPERLINK[0.1], isNull);
  });

  test('should get block fromKey', () {
    // Good request
    expect(INLINES.fromKey('HYPERLINK'), INLINES.HYPERLINK);
    // Bad request
    expect(INLINES.fromKey('NOPE'), isNull);
  });

  test('should get block fromValue', () {
    // Good request
    expect(INLINES.fromValue('entry-hyperlink'), INLINES.ENTRY_HYPERLINK);
    // Bad request
    expect(INLINES.fromValue('not-here'), isNull);
  });

  test('should print', () {
    expect(INLINES.HYPERLINK.toString(), 'INLINES.HYPERLINK');
  });
}
