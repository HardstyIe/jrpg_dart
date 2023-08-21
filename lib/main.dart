import 'package:flutter/material.dart';

import 'screens/gameScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('JRPG Dart')), body: GameScreen()),
    );
  }
}
