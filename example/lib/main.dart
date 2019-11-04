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
          title: Text('Contentful Rich Text Parser Demo'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChildScrollView(
                child: ContentfulRichText(ContentfulData.jsonData)
                    .documentToWidgetTree,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 4),
              ),
              Text('JSON Data:'),
              Expanded(
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
