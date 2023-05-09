import 'package:hola_mundo/src/models/flujo_inventario_model.dart';
export 'package:hola_mundo/src/models/flujo_inventario_model.dart';
import 'package:hola_mundo/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

/* 

CRUD DEL FLUJO DE INVENTARIOS

*/

class FlujoInventarioProvider {
  static Future<Database?> get _database async {
    final db = await DBProvider.db.database;
    return db;
  }

  static nuevoFlujoInventario(FlujoInventarioModel inventario) async {
    try {
  final db = await _database; //obtiene o referencia la base de datos
  final resultado = await db?.insert('FlujoInventarios', inventario.toJson());
  return resultado;
} on DatabaseException {
  rethrow;
}
  }

  static Future<FlujoInventarioModel?> getFlujoInventarioPorId(int id) async {
    try {
  final db = await _database;
  final resultado = await db?.query('FlujoInventarios',
      where: 'id = ?',
      whereArgs: [id]); //realiza la consulta a la base de datos
  
  return resultado!.isNotEmpty
      ? FlujoInventarioModel.fromJson(resultado.first)
      : null;
} on DatabaseException {
  rethrow;
}
  }

  static Future<List<FlujoInventarioModel?>> getFlujo() async {
    try {
  final db = await _database;
  final resultado = await db?.query('FlujoInventarios');
  
  List<FlujoInventarioModel> lista = resultado!.isNotEmpty
      ? resultado.map((e) => FlujoInventarioModel.fromJson(e)).toList()
      : [];
  return lista;
} on DatabaseException {
  rethrow;
}
  }

  //actualizar registros

  static Future<int> actualizarFlujoInventario(
      FlujoInventarioModel inventario) async {
    try {
  final db = await _database;
  final resultado = await db!.update('FlujoInventarios', inventario.toJson(),
      where: 'id = ?', whereArgs: [inventario.id]);
  return resultado;
} on DatabaseException {
  rethrow;
}
  }

  //borrar registros

  static Future<int> eliminarFlujoInventario(int id) async {
    try {
  final db = await _database;
  final resultado =
      await db!.delete('FlujoInventarios', where: 'id = ?', whereArgs: [id]);
  return resultado;
} on DatabaseException {
  rethrow;
}
  }

  static Future<int> eliminarTodosLosFlujos() async {
    try {
  final db = await _database;
  final resultado = await db!.rawDelete('DELETE FROM FlujoInventarios');
  print('TODOS LOS FLUJOS ELIMINADOS');
  
  return resultado;
} on DatabaseException {
 rethrow;
}
  }
}
