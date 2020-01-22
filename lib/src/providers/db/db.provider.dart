import 'dart:io';
import 'package:rotary/src/models/Socio.dart';
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
    await deleteDatabase(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      final Batch batch = db.batch()
        ..execute(
            'CREATE TABLE IF NOT EXISTS socio(id INTEGER PRIMARY KEY AUTOINCREMENT,nme TEXT,cc TEXT,psw TEXT,ste INTEGER);');
      await batch.commit();
    });
  }

  Future<int> insertSocio(Socio socio) async {
    final db = await database;
    return await db.insert('socio', socio.toJson()).then((res) {
      return res;
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> updateSocio(Socio socio) async {
    final db = await database;
    return await db.update('socio', socio.toJson(),
        where: 'cc = ?', whereArgs: [socio.numeroCedula]).then((res) {
      return res;
    }).catchError((err) {
      print(err);
    });
  }

  Future<Socio> getSocioByCC(String cc) async {
    final db = await database;
    return await db.query('socio', where: 'cc = ?', whereArgs: [cc]).then((sc) {
      return sc.isNotEmpty ? Socio.fromJson(sc.first) : null;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<Socio>> getAllSocio() async {
    final db = await database;
    return await db.query('socio').then((scs) {
      return scs.isNotEmpty
          ? List<Socio>.from(scs.map((x) => Socio.fromJson(x)))
          : [];
    });
  }
}
