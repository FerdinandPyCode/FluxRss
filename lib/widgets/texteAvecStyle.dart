import 'package:flutter/material.dart';

class TexteAvecStyle extends Text{
 TexteAvecStyle(data,{textAlign : TextAlign.center ,color:Colors.indigo ,fontSize:15.0,fontStyle:FontStyle.italic}):
      super(
      data,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle
      )
    );

}