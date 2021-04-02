import 'dart:io';

import 'package:daftar_lagu/models/artistItem.dart';
import 'package:daftar_lagu/models/songItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'daftarLagu.db';

    //create, read databases
    var daftarLaguDatabase =
        openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return daftarLaguDatabase;
  }

  // untuk membuat tabel pada database
  void _createDb(Database db, int version) async {
    var batchTemp = db.batch();
    // tabel artistItem
    await batchTemp.execute('''CREATE TABLE artistItem (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT)''');
    // tabel songItem
    await batchTemp.execute('''CREATE TABLE songItem(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT, 
          writer TEXT, 
          artistId INTEGER, 
          FOREIGN KEY (artistId) REFERENCES artistItem(id))''');
    batchTemp.commit();
  }

  //select data tabel ArtistItem
  Future<List<Map<String, dynamic>>> selectArtistItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('artistItem', orderBy: 'name');
    return mapList;
  }

  //select data tabel SongItem
  Future<List<Map<String, dynamic>>> selectSongItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('songtItem', orderBy: 'title');
    return mapList;
  }

  // insert data tabel ArtistItem
  Future<int> insertArtistItem(ArtistItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('artistItem', object.toMap());
    return count;
  }

  // insert data tabel SongItem
  Future<int> insertSongItem(SongItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('songItem', object.toMap());
    return count;
  }

  //update data tabel ArtistItem
  Future<int> updateArtistItem(ArtistItem object) async {
    Database db = await this.initDb();
    int count = await db.update('artistItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update data tabel SongItem
  Future<int> updateSongItem(SongItem object) async {
    Database db = await this.initDb();
    int count = await db.update('songItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete data tabel ArtistItem
  Future<int> deleteArtistItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('artistItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data tabel SongItem
  Future<int> deleteSongItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('songItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<ArtistItem>> getArtistItemList() async {
    var itemMapList = await selectArtistItem();
    int count = itemMapList.length;
    List<ArtistItem> itemList = List<ArtistItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(ArtistItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<SongItem>> getSongItemList() async {
    var itemMapList = await selectSongItem();
    int count = itemMapList.length;
    List<SongItem> itemList = List<SongItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(SongItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
