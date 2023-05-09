import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/usuario_provider.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:hola_mundo/src/views/crearProducto.dart';
import 'package:hola_mundo/src/views/listarProductosTarjeta.dart';
import 'package:hola_mundo/src/views/listarUsuario.dart';

class listarProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _listarProducto();
  }
}

class _listarProducto extends State<listarProducto> {
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
        title: Text(
          "Lista Productos",
          style: TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.view_array_rounded),
              tooltip: "listar Producto Tarjeta",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => listarProductoTarjeta()));
              }),
          IconButton(
              icon: Icon(Icons.text_rotate_vertical),
              tooltip: "Buscar",
              onPressed: () => {}),
        ],
      ),

      body: Center(
          child: FutureBuilder(
        future: ProductoProvider.getProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text('Producto: ${snapshot.data![index]!.id}'),
                    subtitle: Column(
                      children: [
                        Text('Codigo: ${snapshot.data![index]!.codigo} '),
                        Text('Nombre: ${snapshot.data![index]!.nombre} '),
                        Text('Nombre: ${snapshot.data![index]!.precio} '),
                        Text('Detalle: ${snapshot.data![index]!.detalles} '),
                        Text('Cantidad: ${snapshot.data![index]!.cantidad} '),
                      ],
                    ));
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

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 1,
        codigo: 'A-1',
        nombre: 'Cemento blanco 25kg',
        precio: 36500,
        detalles: 'Medio bulto cemento blanco - 25 kg',
        cantidad: 25,
        foto: 'assets/cementoB.jpeg',
        creadoPor: 1));

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 2,
        codigo: 'A-2',
        nombre: 'Cemento Gris 50kg',
        precio: 33000,
        detalles: 'Bulto cemento gris - 50 kg',
        cantidad: 30,
        foto: 'assets/cementoG.jpeg',
        creadoPor: 1));

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 3,
        codigo: 'B-1',
        nombre: 'codo pvc ½',
        precio: 1200,
        detalles: 'Accesorio pvc de ½',
        cantidad: 100,
        foto: 'assets/codo.jpeg',
        creadoPor: 1));

    ProductoProvider.nuevoProducto(ProductoModel(
        id: 4,
        codigo: 'B-2',
        nombre: 'Adaptador macho pvc ½',
        precio: 1200,
        detalles: 'Accesorio pvc de ½',
        cantidad: 50,
        foto: 'assets/adaptadorM.jpeg',
        creadoPor: 1));

    //imprimir los productos y usuarios creados

    ProductoProvider.getProductos();
    //  ProductoProvider.nuevoProducto(ProductoModel(id: 2, codigo: 'sss', nombre: 'destornillador', creadoPor: 7));
  }

//elimina todos los usuarios de la base de datos
  eliminarDatos() async {
    // await UsuarioProvider.database;
    ProductoProvider.eliminarTodosLosProductos();
  }
}
