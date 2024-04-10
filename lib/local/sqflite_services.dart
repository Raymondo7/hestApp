import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../api/VisiteurServices.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'local.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE visiteurs(
          id INTEGER PRIMARY KEY, 
          nom TEXT, 
          numero INTEGER, 
          motif TEXT, 
          arrivee TEXT NULL , 
          depart TEXT NULL
          )
        ''');
    await db.execute('''
          CREATE TABLE cookies(
          id INTEGER PRIMARY KEY, 
          status TEXT , 
          code TEXT NULL
          )
        ''');
    await db.rawInsert('''
      INSERT INTO cookies 
      (status, code) 
      VALUES(?,?)
      ''',
        ['null','null']);

  }

  Future<Status?> getStatus() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('cookies',
        limit: 1);

    if (maps.isNotEmpty) {
      return Status.fromMap(maps[0]);
    } else {
      return null;
    }
  }
  Future<void> updateStatus(String status,String code) async {
    final Database db = await database;

    // Utilisez la requête SQL UPDATE pour mettre à jour le nom de l'admin
    await db.rawUpdate(
      'UPDATE cookies SET status = ?, code = ? WHERE id = ?',
      [status,code, 1],
    );
  }


  Future<List<Visiteur>> fetchVisiteurs() async{
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'visiteurs',
      orderBy: 'id DESC', // Triez par la colonne 'date' de manière décroissante
    );
    return result.map((map) => Visiteur.fromMap(map)).toList();
  }

  Future<void> addVisiteur(Visiteur visiteur) async {
    Database db = await database;
    await db.insert(
      'visiteurs',
      visiteur.toMap(),
    );
  }

  Future<int> deleteVisiteur(int id) async {
    Database db = await database;
    return await db.delete('visiteurs', where: 'id = ?', whereArgs: [id]);
  }
}