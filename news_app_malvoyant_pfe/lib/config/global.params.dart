import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalParams{

    static  List<Map <String , dynamic>> menus =[
      {
        "title":"Acceuil",
        "icon": Icon(Icons.home, color: Colors.blueAccent,),
        "route":"/acceuil",
      },
      {
        "title":"Source",
        "icon": Icon(Icons.source, color: Colors.blueAccent,),
        "route":"/source",
      },
      {
        "title":"Parametres",
        "icon": Icon(Icons.settings, color: Colors.blueAccent,),
        "route":"/setting",
      },
      {
        "title":"Apropos",
        "icon": Icon(Icons.info, color: Colors.blueAccent,),
        "route":"/apropos",
      },
      {
        "title":"Comment utiliser l'applecation",
        "icon": Icon(Icons.device_unknown_sharp, color: Colors.blueAccent,),
        "route":"/home",
      }
    ];
}