import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: use_key_in_widget_constructors
class CrearProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CrearProducto();
}

class _CrearProducto extends State<CrearProducto> {
  late String _codigo;
  late String _nombre;
  late String _detalles;
  late String _cantidad;
  late String _precio;

  File? file;
  ImagePicker image = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCodigo() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Codigo'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El codigo es requerido';
        }
        if (value.length < 2) {
          return 'El codigo debe tener minimo 2 caracteres';
        }
        return null;
      },
      onSaved: (String? value) {
        _codigo = value!;
      },
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nombre'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El nombre es requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        _nombre = value!;
      },
    );
  }

  Widget _buildDetalle() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Detalles'),
      onSaved: (String? value) {
        _detalles = value!;
      },
    );
  }

  Widget _buildCantidad() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Cantidad'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'La cantidad es requerida';
        }
        if (int.parse(value) <= 0) {
          return 'La cantidad no puede ser negativa';
        }

        return null;
      },
      onSaved: (String? value) {
        _cantidad = value!;
      },
    );
  }

  Widget _builPrecio() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Precio'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El precio es requerido';
        }
        if (int.parse(value) <= 0) {
          return 'El precio debe ser mayor a 0';
        }

        return null;
      },
      onSaved: (String? value) {
        _precio = value!;
      },
    );
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
                          _formKey.currentState!.save();
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
}
