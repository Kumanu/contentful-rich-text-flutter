/*
Things to test:
  isInline
  isBlock
  isTopLevelBlock
  isParagraph
  isHeader
  isText
  isHyperlink
 */

import 'package:contentful_rich_text/types/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final inlineNode = {'nodeType': 'entry-hyperlink'};
  final blockNode = {'nodeType': 'hr'};
  final topLevelBlocNode = {'nodeType': 'hr'};
  final paragraphNode = {'nodeType': 'paragraph'};
  final headerNode = {'nodeType': 'heading-1'};
  final textNode = {'nodeType': 'text'};
  final hyperlinkNode = {'nodeType': 'hyperlink'};

  test('should check if node is inline', () {
    expect(Helpers.isInline(inlineNode), isTrue);
    expect(Helpers.isInline(blockNode), isFalse);
    expect(Helpers.isInline(topLevelBlocNode), isFalse);
    expect(Helpers.isInline(paragraphNode), isFalse);
    expect(Helpers.isInline(headerNode), isFalse);
    expect(Helpers.isInline(textNode), isFalse);
    expect(Helpers.isInline(hyperlinkNode), isTrue);
  });

  test('should check if node is block', () {
    expect(Helpers.isBlock(inlineNode), isFalse);
    expect(Helpers.isBlock(blockNode), isTrue);
    expect(Helpers.isBlock(topLevelBlocNode), isTrue);
    expect(Helpers.isBlock(paragraphNode), isTrue);
    expect(Helpers.isBlock(headerNode), isTrue);
    expect(Helpers.isBlock(textNode), isFalse);
    expect(Helpers.isBlock(hyperlinkNode), isFalse);
  });

  test('should check if node is top level block', () {
    expect(Helpers.isTopLevelBlock(inlineNode), isFalse);
    expect(Helpers.isTopLevelBlock(blockNode), isTrue);
    expect(Helpers.isTopLevelBlock(topLevelBlocNode), isTrue);
    expect(Helpers.isTopLevelBlock(paragraphNode), isTrue);
    expect(Helpers.isTopLevelBlock(headerNode), isTrue);
    expect(Helpers.isTopLevelBlock(textNode), isFalse);
    expect(Helpers.isTopLevelBlock(hyperlinkNode), isFalse);
  });

  test('should check if node is paragraph', () {
    expect(Helpers.isParagraph(inlineNode), isFalse);
    expect(Helpers.isParagraph(blockNode), isFalse);
    expect(Helpers.isParagraph(topLevelBlocNode), isFalse);
    expect(Helpers.isParagraph(paragraphNode), isTrue);
    expect(Helpers.isParagraph(headerNode), isFalse);
    expect(Helpers.isParagraph(textNode), isFalse);
    expect(Helpers.isParagraph(hyperlinkNode), isFalse);
  });

  test('should check if node is header', () {
    expect(Helpers.isHeader(inlineNode), isFalse);
    expect(Helpers.isHeader(blockNode), isFalse);
    expect(Helpers.isHeader(topLevelBlocNode), isFalse);
    expect(Helpers.isHeader(paragraphNode), isFalse);
    expect(Helpers.isHeader(headerNode), isTrue);
    expect(Helpers.isHeader(textNode), isFalse);
    expect(Helpers.isHeader(hyperlinkNode), isFalse);
  });

  test('should check if node is text', () {
    expect(Helpers.isText(inlineNode), isFalse);
    expect(Helpers.isText(blockNode), isFalse);
    expect(Helpers.isText(topLevelBlocNode), isFalse);
    expect(Helpers.isText(paragraphNode), isFalse);
    expect(Helpers.isText(headerNode), isFalse);
    expect(Helpers.isText(textNode), isTrue);
    expect(Helpers.isText(hyperlinkNode), isFalse);
  });

  test('should check if node is hyperlink', () {
    expect(Helpers.isHyperlink(inlineNode), isFalse);
    expect(Helpers.isHyperlink(blockNode), isFalse);
    expect(Helpers.isHyperlink(topLevelBlocNode), isFalse);
    expect(Helpers.isHyperlink(paragraphNode), isFalse);
    expect(Helpers.isHyperlink(headerNode), isFalse);
    expect(Helpers.isHyperlink(textNode), isFalse);
    expect(Helpers.isHyperlink(hyperlinkNode), isTrue);
  });
}
