import 'package:flutter/material.dart';
import 'add_contact.dart';

class Home extends StatefulWidget {
  final String _title;
  // ignore: use_key_in_widget_constructors
  const Home(this._title);
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  List<Client> clients = [
    Client(name: 'Miguel', surname: 'Mora', phone: '302 454 25 93'),
    Client(name: 'Alejandro', surname: 'Perez', phone: '322 412 34 68'),
    Client(name: 'Jhonatan', surname: 'Gutierrez', phone: '301 441 36 98'),
    Client(name: 'Juan', surname: 'Segura', phone: '310 789 90 62')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            onLongPress: () {},
            title: Text(clients[index].name + " " + clients[index].surname),
            subtitle: Text(clients[index].phone),
            leading: CircleAvatar(
              child: Text(clients[index].name.substring(0, 1)),
            ),
            // ignore: prefer_const_constructors
            trailing: Icon(
              Icons.call,
              color: Colors.red,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddContact()))
              .then((newContact) {
            if (newContact != null) {
              setState(() {
                clients.add(newContact);
              });
            }
          });
        },
        tooltip: "Agregar Contacto",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Client {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var surname;
  // ignore: prefer_typing_uninitialized_variables
  var phone;

  Client({this.name, this.surname, this.phone});
}
