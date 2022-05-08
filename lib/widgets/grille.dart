import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'texteAvecStyle.dart';
import 'package:intl/intl.dart';
import 'page_detail.dart';

class Grille extends StatefulWidget {
  late RssFeed feed;

  Grille(RssFeed feed) {
    this.feed = feed;
  }

  @override
  _GrilleState createState() => _GrilleState();
}

class _GrilleState extends State<Grille> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
        itemCount: widget.feed.items!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, i) {
          RssItem item = widget.feed.items![i];
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PageDetail(item);
              }));
            },
            child: Card(
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${item.title}",
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                     Padding(
                       padding: const EdgeInsets.only(left:10.0,top: 10.0),
                       child: TexteAvecStyle((item.author == null)
                              ? "France 24"
                              : ("$item.author")),
                     ),
                      Padding(
                        padding: const EdgeInsets.only(right:10.0,top: 10.0),
                        child: TexteAvecStyle(
                          convertirDate("${item.pubDate}"),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 15.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Image.network(
                          "${item.enclosure!.url}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String convertirDate(String string) {
    String il = "Il y a";
    String format = "yyyy-MM-dd HH:mm:ss";
    var formatter = DateFormat(format);
    DateTime dateTime = formatter.parse(string);

    if (dateTime == null) {
      return "Date inconnue";
    } else {
      var difference = DateTime.now().difference(dateTime);
      var jours = difference.inDays;
      var heures = difference.inHours;
      var minutes = difference.inMinutes;

      if (jours > 1) {
        return "$il $jours jours";
      } else if (jours == 1) {
        return "$il 1 jour";
      } else if (heures > 1) {
        return "$il $heures heures";
      } else if (heures == 1) {
        return "$il 1 heures";
      } else if (minutes > 1) {
        return "$il $minutes minutes";
      } else if (minutes == 1) {
        return "$il 1 minutes";
      } else {
        return "A l'instant";
      }
    }
  }
}
