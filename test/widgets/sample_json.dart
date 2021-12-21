const String paragraphJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
					{
						"data": {},
						"marks": [],
						"value": "This is a paragraph",
						"nodeType": "text"
					}
				],
				"nodeType": "paragraph"
			}
		],
		"nodeType": "document"
  }''';

const String boldMarksJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
					{
						"data": {},
						"marks": [
              {
                "type": "bold"
              }
            ],
						"value": "This is a paragraph",
						"nodeType": "text"
					}
				],
				"nodeType": "paragraph"
			}
		],
		"nodeType": "document"
  }''';

const String boldItalicMarksJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
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
						"value": "This is a paragraph",
						"nodeType": "text"
					}
				],
				"nodeType": "paragraph"
			}
		],
		"nodeType": "document"
  }''';

const String absentMarksJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
					{
						"data": {},
						"value": "This is a paragraph",
						"nodeType": "text"
					}
				],
				"nodeType": "paragraph"
			}
		],
		"nodeType": "document"
  }''';

const String orderedListJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step one",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step two",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step three",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step four",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					}
				],
				"nodeType": "ordered-list"
			},
			{
				"data": {},
				"content": [
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

const String unorderedListJson = '''{
		"data": {},
		"content": [
			{
				"data": {},
				"content": [
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step one",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step two",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step three",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					},
					{
						"data": {},
						"content": [
							{
								"data": {},
								"content": [
									{
										"data": {},
										"marks": [],
										"value": "Step four",
										"nodeType": "text"
									}
								],
								"nodeType": "paragraph"
							}
						],
						"nodeType": "list-item"
					}
				],
				"nodeType": "unordered-list"
			},
			{
				"data": {},
				"content": [
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

const String hrJson = '''{
		"data": {},
      "content": [
        {
          "content": [
            {
              "marks": [],
              "nodeType": "text",
              "value": "hello world",
              "data": {}
            }
          ],
          "data": {},
          "nodeType": "paragraph"
        },
        {
          "content": [
            {
              "marks": [],
              "nodeType": "text",
              "value": "",
              "data": {}
            }
          ],
          "data": {},
          "nodeType": "hr"
        },
        {
          "content": [
            {
              "marks": [],
              "nodeType": "text",
              "value": "",
              "data": {}
            }
          ],
          "data": {},
          "nodeType": "paragraph"
        }
      ],
      "data": {},
      "nodeType": "document"
  } ''';

const String headingJson = '''{
    "data": {},
    "content": [
      {
        "data": {},
        "content": [
          {
            "data": {},
            "marks": [],
            "value": "Testing",
            "nodeType": "text"
          }
        ],
        "nodeType": "heading-1"
      }
    ],
    "nodeType": "document"
  }''';

const String hyperlinkJson = '''{
      "data": {},
      "content": [
        {
          "data": {},
          "content": [
            {
              "nodeType": "hyperlink",
              "content": [
                {
                  "nodeType": "text",
                  "value": "link",
                  "marks": [],
                  "data": {}
                }
              ],
              "data": {
                "uri": "https://url.org"
              }
            }
          ],
          "nodeType": "heading-1"
        }
      ],
      "nodeType": "document"
    }''';
