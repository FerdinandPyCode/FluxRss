import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'texteAvecStyle.dart';
import 'package:intl/intl.dart';
import "page_detail.dart";
import 'package:fluxrss/models/items.dart';

class Liste extends StatefulWidget {
  //late List<Items> items;
  late RssFeed feed;
  Liste(RssFeed feed){
    this.feed=feed;
  }

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final taille = MediaQuery.of(context).size.width / 2.5;
    return ListView.builder(
      itemCount: widget.feed.items!.length,
        itemBuilder: (context,i){
          RssItem item = widget.feed.items![i];
         return Container(
           padding: const EdgeInsets.all(10.0),
           child: Card(
             elevation: 10.0,
             child: InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                   return PageDetail(item);//-777777777777777777777777777777777777777777777777777777777777777
                 }));
               },
               child: Column(

                 children: [
                   Row(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [

                       Padding(
                         padding: const EdgeInsets.only(left: 10.0,top: 5.0),
                         child: TexteAvecStyle(convertirDate("${item.pubDate}"),color: Colors.red,),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(right: 10.0,top: 5.0),
                         child: TexteAvecStyle( (item.author==null) ?"France 24":("$item.author")),
                       ),
                     ],
                   ),
                   padding(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Card(
                         elevation: 7.5,
                         child: Container(
                           width: taille,
                           child: Image.network("${item.enclosure!.url}",fit: BoxFit.cover,),
                         ),
                       ),
                       Container(
                           width: taille,
                           child: Padding(
                             padding: const EdgeInsets.only(right: 7.5),
                             child: Text(
                                 "${item.title}",
                               style: const TextStyle(
                                 fontSize: 20.0,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.blue,
                                 fontStyle: FontStyle.italic
                               ),
                             ),//TexteAvecStyle("${item.title}"),
                           )
                       ),
                     ],
                   ),
                   padding(),
                 ],
               ),
             ),
           ),

         );
        }
    );
  }
Padding padding(){
    return const Padding(padding: EdgeInsets.only(top: 10.0),);
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
