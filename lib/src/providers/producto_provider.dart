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
    try {
      final db = await _database; //obtiene o referencia la base de datos
      final resultado = await db?.insert('Productos', producto.toJson());
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

  static Future<ProductoModel?> getProductoPorId(int id) async {
    try {
      final db = await _database;
      final resultado = await db?.query('Productos',
          where: 'id = ?',
          whereArgs: [id]); //realiza la consulta a la base de datos

      return resultado!.isNotEmpty
          ? ProductoModel.fromJson(resultado.first)
          : null;
    } on DatabaseException {
      rethrow;
    }
  }

  /**
   * Obtiene una lista de productos desde una base de datos.
   * 
   * Retorna un Future que se resuelve con una lista de objetos ProductoModel.
   * Cada objeto ProductoModel representa un producto con sus respectivos atributos.
   * 
   * @return Un Future que se resuelve con una lista de objetos ProductoModel.
   */
  static Future<List<ProductoModel?>> getProductos() async {
    try {
      final db = await _database;
      final resultado = await db?.query('Productos');

      List<ProductoModel> lista = resultado!.isNotEmpty
          ? resultado.map((e) => ProductoModel.fromJson(e)).toList()
          : [];
      lista.forEach((e) => print(
          'Nombre: ${e.nombre}, Codigo: ${e.codigo}, ID: ${e.id}, cantidad: ${e.cantidad} creado por: ${e.creadoPor}'));

      return lista;
    } on DatabaseException {
      rethrow;
    }
  }

  //actualizar registros

  static Future<int> actualizarProducto(ProductoModel producto) async {
    try {
      final db = await _database;
      final resultado = await db!.update('Productos', producto.toJson(),
          where: 'id = ?', whereArgs: [producto.id]);
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

  //borrar registros

  static Future<int> eliminarProducto(int id) async {
    try {
      final db = await _database;
      final resultado =
          await db!.delete('Productos', where: 'id = ?', whereArgs: [id]);
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

  static Future<int> eliminarTodosLosProductos() async {
    try {
      final db = await _database;
      final resultado = await db!.rawDelete('DELETE FROM Productos');
      print('TODOS LOS PRODUCTOS ELIMINADOS');
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }
}
