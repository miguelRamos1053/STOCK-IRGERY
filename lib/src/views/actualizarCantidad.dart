// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hola_mundo/src/providers/producto_provider.dart';
import 'package:image_picker/image_picker.dart';

// ignore: use_key_in_widget_constructors
class ActualizarCantidad extends StatefulWidget {
  final ProductoModel? _producto;
  const ActualizarCantidad(this._producto, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _ActualizarCantidad();
  }
}

class _ActualizarCantidad extends State<ActualizarCantidad> {
  late final String _codigo = widget._producto!.codigo;
  late final String _nombre = widget._producto!.nombre;
  late final String? _detalles = widget._producto!.detalles;
  late final int _cantidad = widget._producto!.cantidad;
  late String _cantidadActu;
  late final int _precio = widget._producto!.precio;
  late final String _foto = widget._producto!.foto;

  File? file;
  ImagePicker image = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCodigo() {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(labelText: 'Codigó'),
      initialValue: _codigo,
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(labelText: 'Nombre'),
      initialValue: _nombre,
    );
  }

  Widget _buildDetalles() {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(labelText: 'Detalles'),
      initialValue: _detalles,
    );
  }

  Widget _buildCantidad() {
    return TextFormField(
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
      readOnly: true,
      decoration: const InputDecoration(labelText: 'Precio'),
      initialValue: '$_precio',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Cantidad"),
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
}
