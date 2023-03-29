import 'package:flutter/material.dart';

import 'package:hola_mundo/src/providers/usuario_provider.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // const HolaMundoHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Menu principal",
          onPressed: () => [],
        ),
        title: Text('Listado de usuarios'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), tooltip: "Buscar", onPressed: () => {})
        ],
      ),
      body: Center(
          child: FutureBuilder(
        future: UsuarioProvider.getUsuarios(),
        builder: (BuildContext context,
            AsyncSnapshot<List<UsuarioModel?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text('Usuario: ${snapshot.data![index]!.id}'),
                    subtitle: Column(
                      children: [
                        Text('Nombre: ${snapshot.data![index]!.nombre} '),
                        Text('Correo: ${snapshot.data![index]!.correo} '),
                        Text(
                            'Contraseña: ${snapshot.data![index]!.contrasenia} '),
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
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              eliminarDatos();
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

//funciones para pruebas
  guardarDatos() async {
    //Crea usuarios de prueba en la base de datos
    await UsuarioProvider.nuevoUsuario(UsuarioModel(
        id: 1,
        nombre: "Alejandro",
        correo: "alejandro@gmail.com",
        contrasenia: "1234"));

    UsuarioProvider.nuevoUsuario(UsuarioModel(
        id: 2,
        nombre: "Brayan",
        correo: "brayan@gmail.com",
        contrasenia: "1234"));
    UsuarioProvider.nuevoUsuario(UsuarioModel(
        id: 3,
        nombre: "Albert",
        correo: "albert@gmail.com",
        contrasenia: "1234"));
    UsuarioProvider.nuevoUsuario(UsuarioModel(
        id: 4,
        nombre: "Miguel",
        correo: "miguel@gmail.com",
        contrasenia: "1234"));

//crear un producto
    ProductoProvider.nuevoProducto(ProductoModel(
        id: 1, codigo: 'sss', nombre: 'destornillador', creadoPor: 1));

    //imprimir los productos y usuarios creados
    UsuarioProvider.getUsuarios();
    ProductoProvider.getProductos();
    //  ProductoProvider.nuevoProducto(ProductoModel(id: 2, codigo: 'sss', nombre: 'destornillador', creadoPor: 7));
  }

//elimina todos los usuarios de la base de datos
  eliminarDatos() async {
    // await UsuarioProvider.database;
    ProductoProvider.eliminarTodosLosProductos();
    UsuarioProvider.eliminarTodosUsuarios();
  }
}
