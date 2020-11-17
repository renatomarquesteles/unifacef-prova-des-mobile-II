import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:prova2bim/model/aviao.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE aviao(id INTEGER PRIMARY KEY, modelo TEXT, ano TEXT, companhia TEXT, passageiros TEXT)');
  }

  Future<int> inserirAviao(Aviao aviao) async {
    var dbClient = await db;
    var result = await dbClient.insert('aviao', aviao.toMap());

    return result;
  }

  Future<List> getAvioes() async {
    var dbClient = await db;
    var result = await dbClient.query('aviao',
        columns: ['id', 'modelo', 'ano', 'companhia', 'passageiros']);

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM aviao'));
  }

  Future<Aviao> getAviao(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query('aviao',
        columns: ['id', 'modelo', 'ano', 'companhia', 'passageiros'],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new Aviao.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteAviao(int id) async {
    var dbClient = await db;
    return await dbClient.delete('aviao', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAviao(Aviao aviao) async {
    var dbClient = await db;
    return await dbClient
        .update('aviao', aviao.toMap(), where: 'id = ?', whereArgs: [aviao.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
