import 'dart:convert';

import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:contentful_rich_text/types/blocks.dart';
import 'package:contentful_rich_text/widgets/heading.dart';
import 'package:contentful_rich_text/widgets/hr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'sample_json.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget _buildWidget(String json) {
    return MaterialApp(
      home: ContentfulRichText(jsonDecode(json)).documentToWidgetTree,
    );
  }

  /*
    Things to test:
      blocks
      helpers (maybe a separate test for that)
      inlines
      marks (especially null handling)

      headings
      hr
      hyperlink
      ordered lists
      unordered lists
   */
  testWidgets('should display paragraph', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(paragraphJson));

    expect(find.text('This is a paragraph'), findsOneWidget);
  });

  testWidgets('should handle missing marks element',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(absentMarksJson));

    expect(find.text('This is a paragraph'), findsOneWidget);
  });

  testWidgets('should display bold marks', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(boldMarksJson));

    final finder = find.text('This is a paragraph');
    expect(finder, findsOneWidget);
    final widget = tester.widget(finder) as Text;
    final span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
  });

  testWidgets('should display bold italics marks', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(boldItalicMarksJson));

    final finder = find.text('This is a paragraph');
    expect(finder, findsOneWidget);
    final widget = tester.widget(finder) as Text;
    final span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontStyle, FontStyle.italic);
  });

  testWidgets('should display ordered list', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(orderedListJson));

    // Find the row for step one
    var finder =
        find.ancestor(of: find.text('Step one'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('1.')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step one')),
        findsOneWidget);

    // Find the row for step two
    finder =
        find.ancestor(of: find.text('Step two'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('2.')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step two')),
        findsOneWidget);

    // Find the row for step three
    finder =
        find.ancestor(of: find.text('Step three'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('3.')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step three')),
        findsOneWidget);

    // Find the row for step four
    finder =
        find.ancestor(of: find.text('Step four'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('4.')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step four')),
        findsOneWidget);
  });

  testWidgets('should display unordered list', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(unorderedListJson));

    // Find the row for step one
    var finder =
        find.ancestor(of: find.text('Step one'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('•')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step one')),
        findsOneWidget);

    // Find the row for step two
    finder =
        find.ancestor(of: find.text('Step two'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('•')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step two')),
        findsOneWidget);

    // Find the row for step three
    finder =
        find.ancestor(of: find.text('Step three'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('•')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step three')),
        findsOneWidget);

    // Find the row for step four
    finder =
        find.ancestor(of: find.text('Step four'), matching: find.byType(Row));
    expect(
        find.descendant(of: finder, matching: find.text('•')), findsOneWidget);
    expect(find.descendant(of: finder, matching: find.text('Step four')),
        findsOneWidget);
  });

  testWidgets('should display horizontal rule', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(hrJson));

    expect(find.text('hello world'), findsOneWidget);
    expect(find.byType(Hr), findsOneWidget);
  });

  testWidgets('should display heading', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(headingJson));

    expect(find.text('Testing'), findsOneWidget);
    final finder = find.byType(Heading);
    expect(finder, findsOneWidget);
    final heading = tester.widget(finder) as Heading;
    expect(heading.level, BLOCKS.HEADING_1);
  });

  testWidgets('should display hyperlink', (WidgetTester tester) async {
    var launched = false;
    MethodChannel('plugins.flutter.io/url_launcher')
        .setMockMethodCallHandler((call) async {
      expect(call.arguments['url'], 'https://url.org');
      if (call.method == 'canLaunch') {
        return true;
      }
      expect(call.method, 'launch');
      launched = true;
      return true;
    });

    await tester.pumpWidget(_buildWidget(hyperlinkJson));

    final finder = find.text('link');
    expect(finder, findsOneWidget);

    // Verify that tapping on the link launches the URL
    await tester.tap(finder);
    await tester.pumpAndSettle();
    expect(launched, isTrue);
  });
}
