import 'package:flutter/material.dart';
import 'package:fluxrss/models/items.dart';
import 'package:fluxrss/widgets/grille.dart';
import 'package:fluxrss/widgets/texteAvecStyle.dart';
import 'package:webfeed/webfeed.dart';
import 'package:fluxrss/models/parser.dart';
import 'dart:async';
import 'chargement.dart';
import 'liste.dart';
import 'grille.dart';
import 'package:fluxrss/models/database_items.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late String _title;
  late RssFeed? _feed = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 10.0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.refresh,
                size: 30.0,
              ),
              onPressed: () {
                setState(() {
                  _feed = null;
                  parse();
                });
              },
            ),
          ),
        ],
      ),

      drawer: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                TexteAvecStyle(
                  "Menu",
                  fontSize: 23.0,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ],
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Politique",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Economie",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Divertissements",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Technologies",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Sports",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TexteAvecStyle(
              "Ajouter une rubrique",
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),

      body:
          choixDuBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /*99999999999999999999999999999999999999999*/

  Future<Null> parse() async {
    RssFeed? recu = await Parser().loadFeed();
    if (recu != null) {
      setState(() {
        _feed = recu;
        DatabaseItems db = DatabaseItems();
        db.addItem(_feed!);
      });
    }
  }

/*999999999999999999999999999999999999999999*/
  Widget choixDuBody() {
    if (_feed == null) {
      return Chargement();
    } else {
      Orientation orientation = MediaQuery.of(context).orientation;
      //DatabaseItems db = DatabaseItems();
      //late List<Items> mesItems;
      //mesItems =db.allitems() as List<Items>;
      if (orientation == Orientation.portrait) {
        //Liste
        return Liste(_feed!);
      } else {
        //Grille
        return Grille(_feed!);
      }
    }
  }
}
