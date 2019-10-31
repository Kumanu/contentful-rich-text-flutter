import 'dart:convert';

class ContentfulData {
  static final Map<String, dynamic> jsonData = json.decode(stringData);
  static const String stringData = '''{
    "data": {},
    "content": [
      {
        "data": {},
        "content": [
          {
            "data": {},
            "marks": [],
            "value": "Testing ",
            "nodeType": "text"
          },
          {
            "data": {
              "uri": "https://google.com"
            },
            "content": [
              {
                "data": {},
                "marks": [
                  {
                    "type": "bold"
                  }
                ],
                "value": "Hyperlink",
                "nodeType": "text"
              },
              {
                "data": {},
                "marks": [
                  {
                    "type": "italic"
                  }
                ],
                "value": " in",
                "nodeType": "text"
              },
              {
                "data": {},
                "marks": [],
                "value": " header",
                "nodeType": "text"
              }
            ],
            "nodeType": "hyperlink"
          },
          {
            "data": {},
            "marks": [],
            "value": "",
            "nodeType": "text"
          }
        ],
        "nodeType": "heading-1"
      },
      {
        "data": {},
        "content": [
          {
            "data": {},
            "marks": [],
            "value": "Testing inline links, ",
            "nodeType": "text"
          },
          {
            "data": {},
            "marks": [
              {
                "type": "bold"
              }
            ],
            "value": "so",
            "nodeType": "text"
          },
          {
            "data": {},
            "marks": [
              {
                "type": "bold"
              },
              {
                "type": "italic"
              }
            ],
            "value": " ",
            "nodeType": "text"
          },
          {
            "data": {
              "uri": "https://google.com"
            },
            "content": [
              {
                "data": {},
                "marks": [
                  {
                    "type": "italic"
                  },
                  {
                    "type": "bold"
                  }
                ],
                "value": "here's ",
                "nodeType": "text"
              },
              {
                "data": {},
                "marks": [
                  {
                    "type": "italic"
                  }
                ],
                "value": "a ",
                "nodeType": "text"
              },
              {
                "data": {},
                "marks": [],
                "value": "link",
                "nodeType": "text"
              }
            ],
            "nodeType": "hyperlink"
          },
          {
            "data": {},
            "marks": [],
            "value": " inline",
            "nodeType": "text"
          }
        ],
        "nodeType": "paragraph"
      },
      {
        "data": {},
        "content": [
          {
            "data": {},
            "marks": [],
            "value": "telephone: ",
            "nodeType": "text"
          },
          {
            "data": {
              "uri": "tel:800-555-1212"
            },
            "content": [
              {
                "data": {},
                "marks": [],
                "value": "800-555-1212",
                "nodeType": "text"
              }
            ],
            "nodeType": "hyperlink"
          },
          {
            "data": {},
            "marks": [],
            "value": "",
            "nodeType": "text"
          }
        ],
        "nodeType": "paragraph"
      },
      {
        "data": {},
        "content": [
          {
            "data": {},
            "marks": [],
            "value": "email: ",
            "nodeType": "text"
          },
          {
            "data": {
              "uri": "mailto:info@example.com"
            },
            "content": [
              {
                "data": {},
                "marks": [],
                "value": "info@example.com",
                "nodeType": "text"
              }
            ],
            "nodeType": "hyperlink"
          },
          {
            "data": {},
            "marks": [],
            "value": "",
            "nodeType": "text"
          }
        ],
        "nodeType": "paragraph"
      }
    ],
    "nodeType": "document"
  }''';
}
