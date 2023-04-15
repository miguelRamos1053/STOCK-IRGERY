import 'package:hola_mundo/src/models/producto_model.dart';
export 'package:hola_mundo/src/models/producto_model.dart';

import 'package:hola_mundo/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
CRUD DE LOS PRODUCTOS

 */
class ProductoProvider {
  static Future<Database?> get _database async {
    final db = await DBProvider.db.database;
    return db;
  }

  static nuevoProducto(ProductoModel producto) async {
    final db = await _database; //obtiene o referencia la base de datos
    final resultado = await db?.insert('Productos', producto.toJson());
    return resultado;
  }

  static Future<ProductoModel?> getProductoPorId(int id) async {
    final db = await _database;
    final resultado = await db?.query('Productos',
        where: 'id = ?',
        whereArgs: [id]); //realiza la consulta a la base de datos

    return resultado!.isNotEmpty
        ? ProductoModel.fromJson(resultado.first)
        : null;
  }

  static Future<List<ProductoModel?>> getProductos() async {
    final db = await _database;
    final resultado = await db?.query('Productos');

    List<ProductoModel> lista = resultado!.isNotEmpty
        ? resultado.map((e) => ProductoModel.fromJson(e)).toList()
        : [];
    lista.forEach((e) => print(
        'Nombre: ${e.nombre}, Codigo: ${e.codigo}, ID: ${e.id}, cantidad: ${e.cantidad} creado por: ${e.creadoPor}'));

    return lista;
  }

  //actualizar registros

  static Future<int> actualizarProducto(ProductoModel producto) async {
    final db = await _database;
    final resultado = await db!.update('Productos', producto.toJson(),
        where: 'id = ?', whereArgs: [producto.id]);
    return resultado;
  }

  //borrar registros

  static Future<int> eliminarProducto(int id) async {
    final db = await _database;
    final resultado =
        await db!.delete('Productos', where: 'id = ?', whereArgs: [id]);
    return resultado;
  }

  static Future<int> eliminarTodosLosProductos() async {
    final db = await _database;
    final resultado = await db!.rawDelete('DELETE FROM Productos');
    print('TODOS LOS PRODUCTOS ELIMINADOS');
    return resultado;
  }
}
