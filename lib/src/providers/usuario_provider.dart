import 'package:hola_mundo/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';
export 'package:hola_mundo/src/providers/db_provider.dart';

/*
CRUD DE LOS USUARIOS
 */
class UsuarioProvider {
  static Future<Database?> get _database async {
    final db = await DBProvider.db.database;
    return db;
  }

  static nuevoUsuario(UsuarioModel nuevoUsuario) async {
    try {
      final db = await _database; //obtiene o referencia la base de datos
      final resultado = await db?.insert('Usuarios', nuevoUsuario.toJson());
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

  static Future<UsuarioModel?> getUsuarioPorId(int id) async {
    try {
      final db = await _database;
      final resultado = await db?.query('Usuarios',
          where: 'id = ?',
          whereArgs: [id]); //realiza la consulta a la base de datos

      return resultado!.isNotEmpty
          ? UsuarioModel.fromJson(resultado.first)
          : null;
    } on DatabaseException {
      rethrow;
    }
  }

  static Future<List<UsuarioModel?>> getUsuarios() async {
    try {
      final db = await _database;
      final resultado = await db?.query('Usuarios');

      List<UsuarioModel> lista = resultado!.isNotEmpty
          ? resultado.map((e) => UsuarioModel.fromJson(e)).toList()
          : [];
      lista.forEach((e) => print(
          'Nombre: ${e.nombre}, Correo: ${e.correo}, ID: ${e.id}, contraseña: ${e.contrasenia}'));
      return lista;
    } on DatabaseException {
      rethrow;
    }
  }

  /**
   * Actualiza un usuario en la base de datos.
   * 
   * Recibe un objeto UsuarioModel que contiene la información actualizada del usuario.
   * Retorna un Future que se resuelve con un entero que representa si fue actualizado o no.
   * 
   * @param nuevoUsuario El objeto UsuarioModel con la información actualizada del usuario.
   * @return Un Future que se resuelve con un entero que representa si fue actualizado o no.
   */
  static Future<int> actualizarUsuario(UsuarioModel nuevoUsuario) async {
    try {
      final db = await _database;
      final resultado = await db!.update('Usuarios', nuevoUsuario.toJson(),
          where: 'id = ?', whereArgs: [nuevoUsuario.id]);
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

  //borrar registros

  static Future<int> eliminarUsuario(int id) async {
    try {
      final db = await _database;
      final resultado =
          await db!.delete('Usuarios', where: 'id = ?', whereArgs: [id]);
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

//Vaciar la tabla de usuarios
  static Future<int> eliminarTodosUsuarios() async {
    try {
      final db = await _database;
      final resultado = await db!.rawDelete('DELETE FROM Usuarios');
      print('TODOS LOS USUARIOS ELIMINADOS');

      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }

//muestra todas las tablas que la base de datos contiene
  static Future<List<Map<String, dynamic>>> getTablas() async {
    try {
      final db = await _database;

      final List<Map<String, dynamic>> tables =
          await db!.rawQuery('SELECT * FROM sqlite_master');

      print(tables);
      return tables;
    } on DatabaseException {
      rethrow;
    }
  }

//crear un usuario
  static crearUsuario(UsuarioModel nuevoUsuario) async {
    try {
      final db = await _database;
      final resultado = await db?.insert('Usuarios', nuevoUsuario.toJson());
      return resultado;
    } on DatabaseException {
      rethrow;
    }
  }
}
