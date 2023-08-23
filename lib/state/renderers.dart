import 'package:flutter/material.dart';

class Renderers {
  late Map<dynamic, Function> renderNode;
  late Map<dynamic, TextStyle> renderMark;
  late TextStyle defaultStyle;
}

Renderers singletonRenderers = Renderers();
