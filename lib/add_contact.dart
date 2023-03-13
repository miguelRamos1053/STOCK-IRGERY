import 'package:flutter/material.dart';
import 'home.dart';
import 'text_box.dart';

// ignore: use_key_in_widget_constructors
class AddContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContact();
}

class _AddContact extends State<AddContact> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerSurname = TextEditingController();
    controllerPhone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Contacto"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Nombre"),
          TextBox(controllerSurname, "Apellido"),
          TextBox(controllerPhone, "Telefono"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String surname = controllerSurname.text;
                String phone = controllerPhone.text;

                if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
                  Navigator.pop(context,
                      Client(name: name, surname: surname, phone: phone));
                }
              },
              child: const Text("Guardar Contacto")),
        ],
      ),
    );
  }
}
