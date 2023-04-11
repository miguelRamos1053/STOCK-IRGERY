import 'package:flutter/material.dart';
import 'package:hola_mundo/src/views/listarProducto.dart';
import 'package:hola_mundo/src/views/listarProductosTarjeta.dart';
import 'package:hola_mundo/src/views/listarUsuario.dart';
import 'package:hola_mundo/home.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Menu principal",
          onPressed: () => [],
        ),
        title: Text("Menu"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width),
            //--- BOTONES DEL MENU -----------------------------------------------
            ElevatedButton(
                child: Text("PRODUCTOS"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => listarProducto()));
                }),
            ElevatedButton(
                child: Text("PRODUCTOS TARJETA"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => listarProductoTarjeta()));
                }),
            ElevatedButton(
                child: Text("USUARIOS"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => listaUsuario()));
                }),
          ]),
    );
  }
}
