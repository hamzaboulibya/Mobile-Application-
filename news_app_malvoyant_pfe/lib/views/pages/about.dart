import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_malvoyant_pfe/api/text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  Speech speech =Speech();
  initState(){
    super.initState();
    speech.stop();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 30, left: 10),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                //  left: 10,
                //alignment: Alignment.bottomCenter,
                child: Container(
                    width: size.width,
                    margin: EdgeInsets.only(
                      left: 1,
                      top: 30,
                    ),
                    child: Column(children: [
                      Text(
                        "YourNews 1.1.1 (1234)",
                        style: TextStyle(
                          //color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        margin: EdgeInsets.only(top: 10, right: 100),
                        child: Text("@2021-2022 <support@YourNews.yn> ",
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, right: 270),
                        child: Text('site web :'),
                      ),
                      new InkWell(
                          child: new Text(
                            'http://www.yournews.com',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () => launch('http://www.yournews.com')),
                      Container(
                        padding: EdgeInsets.only(top: 25, bottom: 2),
                        margin: EdgeInsets.only(top: 15, right: 250),
                        child: Text("description ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                      ),
                      Divider(
                        color: Colors.blue,
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '  Yournews est une application adaptée pour les malvoyants . \n yournews vous permet : \n >lire les actualités pour les malvoyants et aussi pour les personnes normales . \n >faire des commandes vocales pour contrôler l\'application',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25),
                        margin: EdgeInsets.only(top: 15, right: 200),
                        child: Text("remercienments  ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                      ),
                      Divider(
                        color: Colors.blue,
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 200),
                        child: Text(
                          ' -> abdealouahd sabri \n ->meriem ahjouji \n -> Hamza boulibya',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                      ),
                    ])),
              ),
            ],
          )),
    );
  }
}