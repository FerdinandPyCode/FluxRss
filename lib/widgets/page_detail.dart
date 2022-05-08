import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'texteAvecStyle.dart';
import 'package:intl/intl.dart';

class PageDetail extends StatelessWidget {

  late RssItem item;

  PageDetail(RssItem item) {
    this.item = item;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: (
          AppBar(
            title: Text("Detail de l'article"),
            centerTitle: true,
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            padding(),
        Text(
          "${item.title}",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontStyle: FontStyle.italic
          ),
        ),
            padding(),
            Card(
              elevation: 10.0,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.5,
                child: Image.network("${item.enclosure!.url}"),
              ),
            ),
            padding(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TexteAvecStyle(
                      (item.author == null) ? "France 24" : ("$item.author")),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TexteAvecStyle(
                      convertirDate("${item.pubDate}"), color: Colors.red),
                ),
              ],
            ),
            padding(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TexteAvecStyle("${item.description}",fontSize: 20.0,),
            ),
            padding(),
          ],
        ),
      ),
    );
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
  Padding padding(){
    return Padding(padding: EdgeInsets.only(top: 20.0));
  }
}