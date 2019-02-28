# Contentful Rich Text Renderer for Flutter

Rich Text renderer that parses Contentful Ric

## Installation

To use this plugin, add `contentful_rich_text` as a dependency in your pubspec.yaml file.

## Usage

```dart
import 'package:contentful_rich_text/contentful_rich_text.dart';

var document = {
  nodeType: 'document',
  content: [
    {
      nodeType: 'paragraph',
      content: [
        {
          nodeType: 'text',
          value: 'Hello world!',
          marks: [],
        },
      ],
    },
  ],
};

class Demo extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ContentfulRichText(document).documentToWidgetTree;
    // RichText(text: 'Hello World');
  }
}
```

```dart
import 'package:contentful_rich_text/contentful_rich_text.dart';

var document = {
  nodeType: 'document',
  content: [
    {
      nodeType: 'paragraph',
      content: [
        {
          nodeType: 'text',
          value: 'Hello',
          marks: [{ type: 'bold' }],
        },
        {
          nodeType: 'text',
          value: ' world!',
          marks: [{ type: 'italic' }],
        },
      ],
    },
  ],
};

class Demo extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ContentfulRichText(document).documentToWidgetTree;
    // RichText(
    //   text: '',
    //   children: <Widgets>[
    //     TextSpan(text: 'Hello', style: { fontWeight: FontWeight.bold }),
    //     TextSpan(text: ' world!', style: { fontStyle: FontStyle.italic }), 
    //   ],
    // );
  }
}
```

You can also pass custom renderers for both marks and nodes as an optional parameter like so:

```javascript
import 'package:contentful_rich_text/contentful_rich_text.dart';

var document = {
  nodeType: 'document',
  data: {},
  content: [
    {
      nodeType: 'paragraph',
      data:{},
      content: [
        {
          nodeType: 'text',
          value: 'Hello',
          marks: [{ type: 'bold' }],
          data: {}
        },
        {
          nodeType: 'text',
          value: ' world!',
          marks: [{ type: 'italic' }]
          data: {}
        },
      ],
    },
  ]
};

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
    // CustomParagraph(
    // ...
    // );
  }
}
```

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
  - `UL_LIST`
  - `OL_LIST`
  - `LIST_ITEM`
  - ~~`QUOTE`~~ // not implemented yet
  - `HR`
  - ~~`EMBEDDED_ENTRY`~~ // not implemented yet
  - ~~`EMBEDDED_ASSET`~~ // not implemented yet

- `INLINES`
  - `EMBEDDED_ENTRY` (this is different from the `BLOCKS.EMBEDDED_ENTRY`) // not implemented yet
  - `HYPERLINK` // not implemented yet
  - ~~`ENTRY_HYPERLINK`~~ // not implemented yet
  - ~~`ASSET_HYPERLINK`~~ // not implemented yet

The `renderMark` keys should be the value of one of the following `MARKS` properties as defined in [`contentful_rich_text/types`](https://github.com/JOOLHealth/contentful_rich_text/tree/master/lib/types):

- `BOLD`
- `ITALIC`
- `UNDERLINE`
- ~~`CODE`~~ // not implemented yet