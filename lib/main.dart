import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home("Mis contactos"),
    ); // MaterialApp
  }
}
