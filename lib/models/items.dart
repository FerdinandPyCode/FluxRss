import 'package:sqflite/sqflite.dart';

class Items {
  late int id;
  late int jaime;
  late String author;
  late String title;
  late String category;
  late String description;
  late String image_link;
  late String link;
  late String datePub;

  Items();

  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    author = map['author'];
    title = map['title'];
    category = map['category'];
    description = map['description'];
    image_link = map['image_link'];
    link = map['link'];
    datePub = map['datePub'];
    jaime = map["jaime"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "author": author,
      "title": title,
      "category": category,
      "description": description,
      "image_link": image_link,
      "link": link,
      "datePub": datePub,
      "jaime": jaime,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
