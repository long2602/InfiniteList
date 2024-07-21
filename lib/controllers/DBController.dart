import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/FavoriteProduct.dart';

class DBController {
  static final DBController _instance = DBController._internal();
  static Database? _db;

  factory DBController() {
    return _instance;
  }

  DBController._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dataDirPath = await getDatabasesPath();
    final dataPath = join(dataDirPath, "InfiniteList");
    final database = await openDatabase(
      dataPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE IF NOT EXISTS favorite ( id INTEGER NOT NULL PRIMARY KEY, idProduct INTEGER NOT NULL);');
      },
    );
    return database;
  }

  void insertItemIntoFavorite(int idProduct) async {
    final db = await database;
    await db.insert("favorite", {"idProduct": idProduct});
  }

  void deleteItemIntoFavorite(int id) async {
    final db = await database;
    db.delete(
      "favorite",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<FavoriteProduct>> getFavoriteList() async {
    List<FavoriteProduct> list = [];
    final db = await database;
    final data = await db.query("favorite");
    for (var item in data) {
      list.add(FavoriteProduct(id: item['id'] as int, idProduct: item['idProduct'] as int));
    }
    return list;
  }
}
