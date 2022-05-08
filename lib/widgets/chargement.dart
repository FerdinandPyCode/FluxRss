import 'package:flutter/material.dart';
import 'texteAvecStyle.dart';

class Chargement extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: TexteAvecStyle(
        "Chargement en cours...",
        fontStyle: FontStyle.italic,
        fontSize: 30.0,
      ),
    );
  }
}