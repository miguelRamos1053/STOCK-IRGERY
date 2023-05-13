// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import '../providers/producto_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'listarProducto.dart';

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
  late final int? _id = widget._producto!.id;
  late final String _codigo = widget._producto!.codigo;
  late final String _nombre = widget._producto!.nombre;
  late final String? _detalles = widget._producto!.detalles;
  late final int _cantidad = widget._producto!.cantidad;
  late int _cantidadActu = 0;
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
        _cantidadActu = int.parse(value!);
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
        title: const Text('Actualizar Cantidad'),
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

                          actualizarPrecio();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text(
                                    'Cantidad actualizada a $_cantidadActu'),
                                children: <Widget>[
                                  Center(

                                      child: TextButton(
                                          child: const Text('Ok'),

                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        listarProducto()));
                                          })),
                                ],
                              );
                            },
                          );
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

  obtenerCantidadActual() async {
    ProductoModel? p = await ProductoProvider.getProductoPorId(_id!);
    int cantidadActual = p!.cantidad;
  }

  actualizarPrecio() async {
    ProductoProvider.actualizarProducto(ProductoModel(
        id: _id,
        codigo: _codigo,
        nombre: _nombre,
        precio: _precio,
        detalles: _detalles,
        cantidad: _cantidadActu,
        foto: _foto,
        creadoPor: 1));
        
  }
}
