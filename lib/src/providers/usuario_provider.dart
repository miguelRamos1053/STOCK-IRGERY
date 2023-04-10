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
    final db = await _database; //obtiene o referencia la base de datos
    final resultado = await db?.insert('Usuarios', nuevoUsuario.toJson());
    return resultado;
  }

  static Future<UsuarioModel?> getUsuarioPorId(int id) async {
    final db = await _database;
    final resultado = await db?.query('Usuarios',
        where: 'id = ?',
        whereArgs: [id]); //realiza la consulta a la base de datos

    return resultado!.isNotEmpty
        ? UsuarioModel.fromJson(resultado.first)
        : null;
  }

  static Future<List<UsuarioModel?>> getUsuarios() async {
    final db = await _database;
    final resultado = await db?.query('Usuarios');

    List<UsuarioModel> lista = resultado!.isNotEmpty
        ? resultado.map((e) => UsuarioModel.fromJson(e)).toList()
        : [];
    lista.forEach((e) => print(
        'Nombre: ${e.nombre}, Correo: ${e.correo}, ID: ${e.id}, contraseña: ${e.contrasenia}'));
    return lista;
  }

  //actualizar registros

  static Future<int> actualizarUsuario(UsuarioModel nuevoUsuario) async {
    final db = await _database;
    final resultado = await db!.update('Usuarios', nuevoUsuario.toJson(),
        where: 'id = ?', whereArgs: [nuevoUsuario.id]);
    return resultado;
  }

  //borrar registros

  static Future<int> eliminarUsuario(int id) async {
    final db = await _database;
    final resultado =
        await db!.delete('Usuarios', where: 'id = ?', whereArgs: [id]);
    return resultado;
  }

//Vaciar la tabla de usuarios
  static Future<int> eliminarTodosUsuarios() async {
    final db = await _database;
    final resultado = await db!.rawDelete('DELETE FROM Usuarios');
    print('TODOS LOS USUARIOS ELIMINADOS');

    return resultado;
  }

//muestra todas las tablas que la base de datos contiene
  static Future<List<Map<String, dynamic>>> getTablas() async {
    final db = await _database;

    final List<Map<String, dynamic>> tables =
        await db!.rawQuery('SELECT * FROM sqlite_master');

    print(tables);
    return tables;
  }
}
