import 'package:flutter/material.dart';
import 'package:hola_mundo/src/views/listarProducto.dart';
import 'package:hola_mundo/src/views/listarProductosTarjeta.dart';
import 'package:hola_mundo/src/views/listarUsuario.dart';

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
      //--- Menu HAMBURGUESA -------------------------------
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70, bottom: 20),
              ),
              const Text(
                "STOCK IRGERY",
                style: TextStyle(fontSize: 30),
              ),
              //----INICIO ---------------------
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => listarProducto()));
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 50),
                    padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    color: Colors.grey[100],
                    child: new Column(children: [
                      new Text("INICIO"),
                    ]),
                  )),
              //----USUARIOS ---------------------
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => listaUsuario()));
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    color: Colors.grey[100],
                    child: new Column(children: [
                      new Text("USUARIOS"),
                    ]),
                  )),

              //-- SALIR ------------------------------------
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Color.fromARGB(221, 43, 142, 199),
                child: const Text(
                  "Salir",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Menu'),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => listarProductoTarjeta()));
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
