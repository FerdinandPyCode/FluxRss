import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Parser {
  Future<RssFeed?> loadFeed() async {
    const String FEED_URL = "http://www.france24.com/fr/actualites/rss";

    final client = http.Client();
    final response = await client.get(Uri.parse(FEED_URL));
    if (response.statusCode == 200) {
      final feed = RssFeed.parse(response.body);
      return feed;
    } else {
      print("Erreur: ${response.statusCode}");
    }
    return null;
  }
}
