import 'dart:convert';

import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:contentful_rich_text/types/inlines.dart';
import 'package:contentful_rich_text/types/types.dart';
import 'package:contentful_rich_text/widgets/hr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'sample_json.dart';

/*
  For full support, it might be worth porting all of the tests at
  https://github.com/contentful/rich-text/blob/master/packages/rich-text-html-renderer/src/__test__/index.test.ts
  over to this package
 */

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget _buildWidget(String json) {
    return MaterialApp(
      home: ContentfulRichText(
        jsonDecode(json),
        options: Options(
          renderNode: RenderNode({}),
          defaultStyle: TextStyle(),
        ),
      ).documentToWidgetTree,
    );
  }

  testWidgets('should display paragraph', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(paragraphJson));

    final finder = find.text('This is a paragraph');
    expect(finder, findsOneWidget);
    final widget = tester.widget(finder) as Text;
    final span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span, isNotNull);
    expect(span?.style, TextStyle());
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

  testWidgets('should display headings', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(headingJson));

    var finder = find.text('test - heading 1');
    expect(finder, findsOneWidget);
    var widget = tester.widget(finder) as Text;
    var span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 24);

    finder = find.text('test - heading 2');
    expect(finder, findsOneWidget);
    widget = tester.widget(finder) as Text;
    span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 22);

    finder = find.text('test - heading 3');
    expect(finder, findsOneWidget);
    widget = tester.widget(finder) as Text;
    span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 20);

    finder = find.text('test - heading 4');
    expect(finder, findsOneWidget);
    widget = tester.widget(finder) as Text;
    span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 18);

    finder = find.text('test - heading 5');
    expect(finder, findsOneWidget);
    widget = tester.widget(finder) as Text;
    span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 16);

    finder = find.text('test - heading 6');
    expect(finder, findsOneWidget);
    widget = tester.widget(finder) as Text;
    span = widget.textSpan?.getSpanForPosition(TextPosition(offset: 0));
    expect(span?.style?.fontWeight, FontWeight.bold);
    expect(span?.style?.fontSize, 14);
  });

  testWidgets('should display hyperlink', (WidgetTester tester) async {
    var launched = false;
    final channel = MethodChannel('plugins.flutter.io/url_launcher');

    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (call) async {
        expect(call.arguments['url'], 'https://url.org');
        if (call.method == 'canLaunch') {
          return true;
        }
        expect(call.method, 'launch');
        launched = true;
        return true;
      },
    );

    await tester.pumpWidget(_buildWidget(hyperlinkJson));

    final finder = find.text('link');
    expect(finder, findsOneWidget);

    // Verify that tapping on the link launches the URL
    await tester.tap(finder);
    await tester.pumpAndSettle();

    expect(launched, isTrue);
  });

  // TODO: Tests for node types yet to be implemented
  //  embedded entry
  //  quote
  //  inline asset hyperlink
  //  inline entry hyperlink

  testWidgets('should display embedded entry', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(embeddedEntryJson));

    // Currently Container is used as a placeholder for embedded entry blocks
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('should display quotes', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(quoteJson));

    expect(find.text('hello'), findsOneWidget);
    // TODO: This should return one widget when implemented
    expect(find.text('world'), findsNothing);

    // Currently Container is used as a placeholder for quotes
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('should display inline asset hyperlink',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(inlineAssetHyperlinkJson));

    // Currently Container is used as a placeholder for unimplemented inlines
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('should display inline entry hyperlink',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(inlineEntryHyperlinkJson));

    // Currently Container is used as a placeholder for unimplemented inlines
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('should display inline embedded entry',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(inlineEmbeddedEntryJson));

    expect(find.text('one'), findsOneWidget);
  });

  testWidgets(
    'should display custom inline embedded entry',
    (WidgetTester tester) async {
      final widget = MaterialApp(
        home: ContentfulRichText(
          jsonDecode(inlineEmbeddedEntryJson),
          options: Options(
            renderNode: RenderNode({
              INLINES.EMBEDDED_ENTRY.value: (node, next) {
                return TextSpan(
                    text: 'embedded entry test',
                    style: TextStyle(
                      color: Colors.black,
                    ));
              },
            }),
            defaultStyle: TextStyle(),
          ),
        ).documentToWidgetTree,
      );

      await tester.pumpWidget(widget);

      // Verify that the text value in the JSON was overwritten by the renderer
      expect(find.text('one'), findsNothing);
      expect(find.text('embedded entry test'), findsOneWidget);
    },
  );
}
