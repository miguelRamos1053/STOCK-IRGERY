import 'package:flutter/material.dart';
import 'package:hola_mundo/src/views/listarProducto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Stock Irgery",
        home: listarProducto());
  }
}

