// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';

import 'package:image_picker/image_picker.dart';

// ignore: use_key_in_widget_constructors
class EditarProducto extends StatefulWidget {
  final ProductoModel? _producto;
  const EditarProducto(this._producto, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _EditarProducto();
  }
}

class _EditarProducto extends State<EditarProducto> {
  late final String _codigo = widget._producto!.codigo;
  late final String _nombre = widget._producto!.nombre;
  late final String? _detalles = widget._producto!.detalles;
  late final int _cantidad = widget._producto!.cantidad;
  late final int _precio = widget._producto!.precio;
  late final String _foto = widget._producto!.foto;

  late String _codigoActual;
  late String _nombreActual;
  late String _detalleActual;
  late String _cantidadActu;
  late String _precioActual;

  File? file;
  ImagePicker image = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCodigo() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Código'),
      initialValue: _codigo,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El código es requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        _codigoActual = value!;
      },
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nombre'),
      initialValue: _nombre,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El nombre es requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        _nombreActual = value!;
      },
    );
  }

  Widget _buildDetalles() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Detalles'),
      initialValue: '$_detalles',
      onSaved: (String? value) {
        _detalleActual = value!;
      },
    );
  }

  Widget _buildCantidad() {
    return TextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      decoration: const InputDecoration(labelText: 'Cantidad'),
      initialValue: '$_cantidad',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'La cantidad es requerida';
        }
        if (int.parse(value) < 0) {
          return 'La cantidad no puede ser negativa';
        }

        return null;
      },
      onSaved: (String? value) {
        _cantidadActu = value!;
      },
    );
  }

  Widget _buildPrecio() {
    return TextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(labelText: 'Precio'),
      initialValue: '$_precio',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'El precio es requerido';
        }
        if (int.parse(value) < 1) {
          return 'El precio tiene que ser mayor a 0';
        }

        return null;
      },
      onSaved: (String? value) {
        _precioActual = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Producto"),
        backgroundColor: Colors.orange[80],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.black12,
                child: Image.asset(_foto),
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
                      _buildDetalles(),
                      _buildCantidad(),
                      _buildPrecio(),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Actualizar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            print("Holaa");

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

  // actualizarPrecio() async {
  //   ProductoProvider.actualizarProducto(ProductoModel(
  //     id: id,
  //     codigo: codigo,
  //     nombre: nombre,
  //     precio: precio,
  //     creadoPor: creadoPor
  //     ));
  // }
}
