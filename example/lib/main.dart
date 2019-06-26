import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';

import './contentful_data.dart';

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
        body: SingleChildScrollView(
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ContentfulRichText(ContentfulData.jsonData)
                        .documentToWidgetTree,
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Colors.black54,
                      ),
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'JSON Data:',
                        )
                      ]),
                    ),
                    Text(ContentfulData.stringData),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
