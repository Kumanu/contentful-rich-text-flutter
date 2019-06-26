import 'package:flutter/material.dart';

class Renderers {
  Map<dynamic, Function> renderNode;
  Map<dynamic, TextStyle> renderMark;
}

Renderers singletonRenderers = Renderers();
