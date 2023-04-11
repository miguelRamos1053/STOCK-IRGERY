import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/usuario_provider.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:hola_mundo/src/views/crearProducto.dart';

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
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  child: Column(
                    children: [
                      /*Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Flexible(child: Image.asset('url.png')),
                      ),*/
                      //Text('${snapshot.data![index]!.codigo} '),
                      Text('${snapshot.data![index]!.nombre} '.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      //Text('Detalle: ${snapshot.data![index]!.detalles} '),
                      Text('Cantidad: ${snapshot.data![index]!.cantidad} '),
                    ],
                  ),
                  color: Colors.white70,
                  elevation: 10.0,
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
