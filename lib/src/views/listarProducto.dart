import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/usuario_provider.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:hola_mundo/src/views/crearProducto.dart';

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
      appBar: AppBar(
        title: Text("Lista Productos"),
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
/* 
    ProductoProvider.nuevoProducto(ProductoModel(
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
*/
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
