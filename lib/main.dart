import 'package:flutter/material.dart';
import 'package:hola_mundo/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "hola Mundo",
        home: HolaMundoHome());
  }
}
