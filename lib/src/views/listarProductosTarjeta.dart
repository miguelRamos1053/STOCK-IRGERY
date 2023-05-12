import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/usuario_provider.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:hola_mundo/src/views/crearProducto.dart';
import 'package:hola_mundo/src/views/listarProducto.dart';
import 'package:hola_mundo/src/views/listarProductosTarjetaAlfetic.dart';
import 'package:hola_mundo/src/views/listarUsuario.dart';

import 'actualizarCantidad.dart';

class listarProductoTarjeta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _listarProductoTarjeta();
  }
}

class _listarProductoTarjeta extends State<listarProductoTarjeta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Lista Productos T", style: TextStyle(fontSize: 14)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.table_view_rounded),
              tooltip: "listar Producto ",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => listarProducto()));
              }),
          IconButton(
              icon: Icon(Icons.text_rotate_vertical),
              tooltip: "Ordenar alfabeticamente",
              onPressed: () => {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (_) => listarProductoTarjetaAlfetic()))
              }),
        ],
      ),
      body: Center(
          child: FutureBuilder(
        future: ProductoProvider.getProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  color: Colors.white70,
                  elevation: 10.0,
                  child: Column(
                    children: [
                      Flexible(child: Image.asset(snapshot.data![index]!.foto)),

                      //Text('${snapshot.data![index]!.codigo} '),
                      Text(
                        '${snapshot.data![index]!.nombre} '.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${snapshot.data![index]!.precio} '.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                      //Text('Detalle: ${snapshot.data![index]!.detalles} '),
                      Text('Cantidad: ${snapshot.data![index]!.cantidad} '),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ActualizarCantidad(
                                      snapshot.data?[index])));
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Cantidad'),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              guardarDatos();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CrearProducto()));
            },
            child: Icon(Icons.add),
            heroTag: 'btn3',
          )
        ],
      ),
    );
  }

  //funciones para pruebas
  guardarDatos() async {
//crear un producto

    /* ProductoProvider.nuevoProducto(ProductoModel(
        id: 1,
        codigo: 'sss',
        nombre: 'destornillador',
        cantidad: 30,
        creadoPor: 1));

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 2,
        codigo: 'A-1',
        nombre: 'Cemento blanco 25kg',
        detalles: 'Medio bulto cemento blanco - 25 kg',
        cantidad: 25,
        creadoPor: 1));
        
    ProductoProvider.nuevoProducto(ProductoModel(
        id: 3,
        codigo: 'B-1',
        nombre: 'codo pvc ½',
        detalles: 'Accesorio pvc de ½',
        cantidad: 100,
        creadoPor: 1));

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 4,
        codigo: 'B-2',
        nombre: 'Adaptador macho pvc ½',
        detalles: 'Accesorio pvc de ½',
        cantidad: 50,
        creadoPor: 1));

    //imprimir los productos y usuarios creados
*/
    ProductoProvider.getProductos();
    //  ProductoProvider.nuevoProducto(ProductoModel(id: 2, codigo: 'sss', nombre: 'destornillador', creadoPor: 7));
  }

//elimina todos los usuarios de la base de datos
  eliminarDatos() async {
    // await UsuarioProvider.database;
    ProductoProvider.eliminarTodosLosProductos();
  }
}
