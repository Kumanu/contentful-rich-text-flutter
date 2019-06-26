# Contentful Rich Text Renderer for Flutter

Rich Text renderer that parses Contentful Rich Text field JSON output and produces a Flutter Widget tree that can be displayed in a Flutter app.

## Installation

To use this plugin, add `contentful_rich_text` as a dependency in your pubspec.yaml file.

## Usage

Note: The json examples are samples of what Contentful's API can return. The `getContentfulJson` method is just a placeholder for where your code would call a method to get your data from the Contentful API.

#### Simple document with paragraph, no inline marks (bold/italic/underline)
###### Sample JSON
```json
{
  "nodeType": "document",
  "content": [
    {
      "nodeType": "paragraph",
      "content": [
        {
          "nodeType": "text",
          "value": "Hello world!",
          "marks": []
        }
      ]
    }
  ]
}
```
###### Sample Dart implementation
```dart
import 'package:contentful_rich_text/contentful_rich_text.dart';

// getting data from Contentful, must be implemented in your project
// document will be a dynamic variable JSON map matching the above JSON
var document = getContentfulJson(); 

class Demo extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ContentfulRichText(document).documentToWidgetTree;
    // Example widget tree produced:
    // Paragraph(
    //   Text(text: 'Hello World'),
    // );
  }
}
```

#### Simple document with paragraph, with bold and italic inline marks
###### Sample JSON
```json
{
  "nodeType": "document",
  "content": [
    {
      "nodeType": "paragraph",
      "content": [
        {
          "nodeType": "text",
          "value": "Hello",
          "marks": [{ "type": "bold" }],
        },
        {
          "nodeType": "text",
          "value": " world!",
          "marks": [{ "type": "italic" }]
        }
      ]
    }
  ]
}
```
###### Sample Dart implementation
```dart
import 'package:contentful_rich_text/contentful_rich_text.dart';

// getting data from Contentful, must be implemented in your project
// document will be a dynamic variable JSON map matching the above JSON
var document = getContentfulJson();

class Demo extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ContentfulRichText(document).documentToWidgetTree;
    // Example widget tree produced:
    // Paragraph(
    //   Text(
    //     text: '',
    //     children: <Widgets>[
    //       TextSpan(text: 'Hello', style: { fontWeight: FontWeight.bold }),
    //       TextSpan(text: ' world!', style: { fontStyle: FontStyle.italic }), 
    //     ],
    //   ),
    // );
  }
}
```

#### Simple document with paragraph, with bold and italic inline marks, using a custom renderer and mark
You can also pass custom renderers for both marks and nodes as an optional parameter like so:
###### Sample JSON
```json
{
  "nodeType": "document",
  "data": {},
  "content": [
    {
      "nodeType": "paragraph",
      "data":{},
      "content": [
        {
          "nodeType": "text",
          "value": "Hello",
          "marks": [{ "type": "bold" }],
          "data": {}
        },
        {
          "nodeType": "text",
          "value": " world!",
          "marks": [{ "type": "italic" }],
          "data": {}
        }
      ]
    }
  ]
}
```
###### Sample Dart implementation
```dart
import 'package:contentful_rich_text/contentful_rich_text.dart';

// getting data from Contentful, must be implemented in your project
// document will be a dynamic variable JSON map matching the above JSON
var document = getContentfulJson();

var options = {
  renderMark: RenderMark defaultMarkRenderers = RenderMark({
    [MARKS.BOLD.value]: () => CustomBoldTextStyle, // returns TextStyle
  }),
  renderNode: RenderNode defaultNodeRenderers = RenderNode({
    [BLOCKS.PARAGRAPH.value]: (node, next) => CustomParagraph(next: next(node.content))
  })
}

class Demo extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ContentfulRichText(document, options).documentToWidgetTree;
    // Example widget tree produced:
    // CustomParagraph(
    //   textStyle: CustomBoldTextStyle(),
    //   ...
    // );
  }
}
```

### RenderNodes
RenderNodes are the various content nodes that Contentful sends for the Rich Text Widget. Blocks are block level items, and inlines are inline items.

Note: Not all of the nodes sent from Contentful are currently implemented. See below for the implementation status.

The `renderNode` keys should be the `value` of one of the following `BLOCKS` and `INLINES` properties as defined in [`contentful_rich_text/types`](https://github.com/JOOLHealth/contentful_rich_text/tree/master/lib/types):

- `BLOCKS`
  - `DOCUMENT`
  - `PARAGRAPH`
  - `HEADING_1`
  - `HEADING_2`
  - `HEADING_3`
  - `HEADING_4`
  - `HEADING_5`
  - `HEADING_6`
  - `UL_LIST` // partially implemented, nested lists are not implemented yet
  - `OL_LIST` // partially implemented, nested lists are not implemented yet
  - `LIST_ITEM`
  - ~~`QUOTE`~~ // not implemented yet
  - `HR`
  - ~~`EMBEDDED_ENTRY`~~ // not implemented yet
  - ~~`EMBEDDED_ASSET`~~ // not implemented yet

- `INLINES`
  - `HYPERLINK`
  - ~~`EMBEDDED_ENTRY`~~ (this is different from the `BLOCKS.EMBEDDED_ENTRY`) // not implemented yet
  - ~~`ENTRY_HYPERLINK`~~ // not implemented yet
  - ~~`ASSET_HYPERLINK`~~ // not implemented yet

### RenderMarks
RenderMarks are the various text styles that can be applied to text inline. 

Note: Not all of the marks sent from Contentful are currently implemented. See below for the implementation status.

The `renderMark` keys should be the value of one of the following `MARKS` properties as defined in [`contentful_rich_text/types`](https://github.com/JOOLHealth/contentful_rich_text/tree/master/lib/types):

- `BOLD`
- `ITALIC`
- `UNDERLINE`
- ~~`CODE`~~ // not implemented yet