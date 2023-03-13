import 'package:flutter/material.dart';

class HolaMundoHome extends StatelessWidget {
  const HolaMundoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Menu principal",
          onPressed: () => [print("Haciendo Click")],
        ),
        title: Text('Titulo principal'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: "Buscar",
              onPressed: () => {print('Buscando..')})
        ],
      ),
      body: Center(
        child: Text('Hola mundo!'),
      ),
    );
  }
}
