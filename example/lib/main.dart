import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:example/contentful_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contentful Rich Text Parser Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contentful Rich Text Parser Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: ContentfulRichText(
                  ContentfulData.jsonData,
                ).documentToWidgetTree,
              ),
              const Divider(height: 2),
              const Text('JSON Data:'),
              const Flexible(
                flex: 6,
                child: SingleChildScrollView(
                  child: Text(ContentfulData.stringData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
