import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'text_box.dart';

// ignore: use_key_in_widget_constructors
class CrearProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CrearProducto();
}

class _CrearProducto extends State<CrearProducto> {
  late TextEditingController controllerCodigo;
  late TextEditingController controllerNombre;
  late TextEditingController controllerDetalles;
  late TextEditingController controllerCantidad;

  @override
  void initState() {
    controllerCodigo = TextEditingController();
    controllerNombre = TextEditingController();
    controllerDetalles = TextEditingController();
    controllerCantidad = TextEditingController();
    super.initState();
  }

  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
      ),
      body: Center(
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
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                TextBox(controllerCodigo, "Codigo"),
                TextBox(controllerNombre, "Nombre"),
                TextBox(controllerDetalles, "Detalles"),
                TextBox(controllerCantidad, "Cantidad"),
                ElevatedButton(
                    onPressed: () {
                      //String codigo = controllerCodigo.text;
                      //String name = controllerNombre.text;
                      //String surname = controllerDetalles.text;
                      //String phone = controllerCantidad.text;
                    },
                    child: const Text("Guardar Producto")),
              ],
            ),
          ],
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
