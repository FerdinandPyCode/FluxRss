import 'dart:async';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'dart:io';
import 'items.dart';

class DatabaseItems {
  late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      //Créer cette base de donnée
      _database = await creer();
      return _database;
    }
  }

  Future addItem(RssFeed _feed) async {
    for (var item in _feed.items!) {
      Items _item = Items();
      Map<String, dynamic> map = {
        "author": item.author,
        "title": item.title,
        "category": item.categories,
        "description": item.description,
        "image_link": item.enclosure!.url,
        "link": item.link,
        "datePub": item.pubDate,
        "jaime": 0,
      };
      _item.fromMap(map);
      ajoutItem(_item);
    }
  }

  Future<Database> creer() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'database.db');
    var bdd =
        await openDatabase(databaseDirectory, version: 1, onCreate: _oncreate);
    return bdd;
  }

  Future _oncreate(Database bd, int version) async {
    await bd.execute("""
      CREATE TABLE Items(
      id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
      author TEXT,
      title TEXT,
      category TEXT,
      description TEXT,
      image_link TEXT,
      link TEXT,
      datePub TEXT,
      jaime INT
      )
      """);
  }
  //Ajout d'un item dans la base de donnée

  Future<void> ajoutItem(Items item) async {
    Database madatabase = await database;
    item.id = await madatabase.insert("Items", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    print(item.id);
  }

  //Lecture des données

  Future<List<Items>> allitems() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.query("Items");
    List<Items> items = [];

    for (var map in resultat) {
      Items item = Items();
      item.fromMap(map);
      items.add(item);
    }
    return items;
  }

  //print(await allitems());
  // SUprimer une donnée

  Future<int> delete(int id, String table) async {
    Database maDatabase = await database;
    return await maDatabase.delete(table, where: 'id=?', whereArgs: [id]);
  }
}
