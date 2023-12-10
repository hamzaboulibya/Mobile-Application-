import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_malvoyant_pfe/views/pages/source_news.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  _SplashScreenState(){
    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        )
      ),

      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 2000),
        child: Container(
          height: 140.0,
          width: 140.0,
          child: Center(
            child: ClipOval(
              child: Icon(Icons.article_outlined,size: 150,color: Colors.white,),
            ),
          ),
        ),
      ),
    );
  }
}
