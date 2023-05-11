// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:hola_mundo/src/views/listarProducto.dart';

// ignore: use_key_in_widget_constructors
class CrearProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CrearProducto();
}

class _CrearProducto extends State<CrearProducto> {
  late String _codigo = "";
  late String _nombre = "";
  late String _detalles = "";
  late int _cantidad = 0;
  late int _precio = 0;

  File? file;
  ImagePicker image = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCodigo() {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Codigo'),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'El codigo es requerido';
          } else if (value.length < 2) {
            return 'El codigo debe tener minimo 2 caracteres';
          } else {
            _codigo = value;
          }
          return null;
        });
  }

  Widget _buildNombre() {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Nombre'),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'El nombre es requerido';
          } else {
            _nombre = value;
          }
          return null;
        });
  }

  Widget _buildDetalle() {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Detalles'),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'El detalle es requerido';
          } else {
            _detalles = value;
          }
          return null;
        });
  }

  Widget _buildCantidad() {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Cantidad'),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'La cantidad es requerida';
          } else if (int.parse(value) < 0) {
            return 'La cantidad no puede ser negativa';
          } else {
            _cantidad = int.parse(value);
          }

          return null;
        });
  }

  Widget _builPrecio() {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Precio'),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'El precio es requerido';
          } else if (int.parse(value) <= 0) {
            return 'El precio debe ser mayor a 0';
          } else {
            _precio = int.parse(value);
          }

          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
        backgroundColor: Colors.orange[80],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 250,
                color: Colors.black12,
                child: file == null
                    ? const Icon(
                        Icons.image,
                        size: 50,
                      )
                    : Image.file(
                        file!,
                        fit: BoxFit.fill,
                      ),
              ),
              MaterialButton(
                color: Colors.blue[900],
                onPressed: () {
                  getGall();
                },
                child: const Text(
                  'Seleccionar desde la galeria',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue[900],
                onPressed: () {
                  getCam();
                },
                child: const Text(
                  'Tomar foto',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _buildCodigo(),
                      _buildNombre(),
                      _buildDetalle(),
                      _buildCantidad(),
                      _builPrecio(),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          guardarDatos(
                              _codigo, _nombre, _precio, _detalles, _cantidad);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => listarProducto()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCam() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getGall() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  guardarDatos(codigo, nombre, precio, detalles, cantidad) async {
    ProductoProvider.nuevoProducto(ProductoModel(
        codigo: codigo,
        nombre: nombre,
        precio: precio,
        detalles: detalles,
        cantidad: cantidad,
        foto: 'assets/cementoB.jpeg',
        creadoPor: 1,
        id: null));
  }
}
