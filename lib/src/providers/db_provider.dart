import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
export 'package:hola_mundo/src/models/usuario_model.dart';

/*
CLASE DE LA CONFIGURACIONn Y CREACION DE LA BASE DE DATOS

 */
class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'stockirgery.db');

    print('path ${path}');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await crearUsuario(db);

        await crearProducto(db);

        await crearFlujoInventario(db);
      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  crearFlujoInventario(db) {
    db.execute('CREATE TABLE FlujoInventarios ('
        'id INTEGER PRIMARY KEY,'
        'fecha TEXT,'
        'tipo TEXT,'
        'cantidad INTEGER NOT NULL,'
        'idProducto INTEGER,'
        'FOREIGN KEY(idProducto) REFERENCES Productos(id)'
        ')');
  }

  crearProducto(db) {
    db.execute('CREATE TABLE Productos ('
        'id INTEGER PRIMARY KEY,'
        'codigo TEXT NOT NULL,'
        'nombre TEXT NOT NULL,'
        'precio INTEGER NOT NULL,'
        'detalles TEXT,'
        'cantidad INTEGER NOT NULL,'
        'foto TEXT,'
        'creadoPor INTEGER,'
        'FOREIGN KEY(creadoPor) REFERENCES Usuarios(id)'
        ')');
  }

  crearUsuario(db) {
    db.execute('CREATE TABLE Usuarios ('
        'id INTEGER PRIMARY KEY,'
        'nombre TEXT NOT NULL,'
        'correo TEXT NOT NULL,'
        'contrasenia TEXT NOT NULL'
        ')');
  }
}
