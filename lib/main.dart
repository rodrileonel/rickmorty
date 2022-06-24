import 'package:flutter/material.dart';
import 'package:rickmorty/app.dart';
import 'core/di.dart' as di;

void main() {
  di.init();
  runApp(const App());
}
