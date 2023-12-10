import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/new_models.dart';
import '../pages/Content.dart';

class ListeTousArticles{

  Widget ListeArticle (int index,String Source, BuildContext context,List<dynamic> articles){
    List listeArticles=[];
    //listeArticles.add(article.description.toString());
    NewsElement article=articles[index];
    FlutterTts flutterTts = FlutterTts();
   // print("l'article maintenant est : ${article.title} and index: ${index}");

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GetNewsConetent(articles: articles,source: Source,index: index,)));
        //flutterTts.speak(x);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.only(left: 12.0, right: 8, top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8.0,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              article.title,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),

            SizedBox(
              height: 1.0,
            ),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                article.description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

