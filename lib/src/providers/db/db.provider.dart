import 'dart:io';
import 'package:rotary/src/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'ponedoras.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      final Batch batch = db.batch()
        ..execute(
            'CREATE TABLE IF NOT EXISTS usuario(id INTEGER PRIMARY KEY AUTOINCREMENT,idUsuario INTEGER, nombreUsuario TEXT,contrasenia TEXT,tipo TEXT,estado INTEGER);');
      await batch.commit();
    });
  }

  Future<int> insertUser(Usuario usuario) async {
    final db = await database;
    return await db.insert('usuario', usuario.toJson()).then((res) {
      return res;
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> updateUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update('usuario', usuario.toJson(),
        where: 'nombreUsuario = ?',
        whereArgs: [usuario.nombreUsuario]).then((res) {
      return res;
    }).catchError((err) {
      print(err);
    });
  }

  Future<Usuario> getUsuarioByUsername(String nombreUsuario) async {
    final db = await database;
    return await db.query('usuario',
        where: 'nombreUsuario = ?', whereArgs: [nombreUsuario]).then((usu) {
      return usu.isNotEmpty ? Usuario.fromJson(usu.first) : null;
    }).catchError((err) {
      print(err);
    });
  }

  Future<Usuario> getUsuario() async {
    final db = await database;
    return await db.query('usuario').then((usu) {
      return usu.isNotEmpty ? Usuario.fromJson(usu.first) : null;
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> deleteUsuario(String nombreUsuario) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete('usuario',
        // Use a `where` clause to delete a specific dog.
        where: "nombreUsuario = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [nombreUsuario]);
  }
}
