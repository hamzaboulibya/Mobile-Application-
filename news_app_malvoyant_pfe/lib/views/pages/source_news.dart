import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_malvoyant_pfe/controllers/news_controllers.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../api/text_to_speech.dart';
import '../../controllers/apinews_controllers.dart';
import '../widget/header_widget.dart';
import 'News_list.dart';
import 'news_page.dart';

class SourceNews extends StatefulWidget {
  const SourceNews({Key? key}) : super(key: key);

  @override
  State<SourceNews> createState() => _SourceNewsState();
}

class _SourceNewsState extends State<SourceNews> {
  double _headerHeight = 250;
  bool isPlaying = true;
  bool isListening = false;
  String _lastWords = '';
  bool _speechEnabled = false;
  int _selectedIndex = 0;
  SpeechToText _speechToText = SpeechToText();
  Speech s=new Speech();
  static const IconData capitol = IconData(0xe95a, fontFamily: 'MyFlutterApp');
  @override
  initState() {
    super.initState();
    print("hello");
    s.stop();
    _initSpeech();
    runTextToSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 120),
      pauseFor: Duration(seconds: 120),
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (_lastWords.contains("pause")) {
        print("ana f comd pause");
        stop();

      }
      if (_lastWords.contains("lire")) {
        print("ana f comd lire");
        runTextToSpeech();
      }
      _lastWords = '';
     /* if (_lastWords.contains("1")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsPage(),
            ));
      }*/

      if (_lastWords.contains("2")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsList(source: "sport",index: 1),
            ));
      }

      if (_lastWords.contains("3")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsList(source: "acceuil",index: 2),
            ));
      }
      if (_lastWords.contains("4")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsList(source: "monde",index: 3),
            ));
      }
      if (_lastWords.contains("5")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsList(source: "acceuil_ar",index: 4),
            ));
      }
      if (_lastWords.contains("6")) {
        print(_lastWords);
        stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsList(source: "economie",index: 5),
            ));
      }
    });

  }
  void lecture() {
    setState(() {
      isPlaying ? stop() : runTextToSpeech();
    });
  }

  Future stop() async {
      setState(() {
        isPlaying = false;
        _lastWords = '';
        print('Stop ${isPlaying}');
       // ttsState = TtsState.stopped;
      });
      await s.stop();
    //setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    s.flutterTts.stop();
  }


  Future<void> runTextToSpeech() async {
    setState(() {
      isPlaying = true;
      print('lectuer ${isPlaying}');
      _lastWords = '';
    });
    dynamic text="Bonjour dans la page de source ,cette page contient six sources sont :"
        " source 1 apinews de maroc  ,2 site info sport ,3 site info acceuil,4 site info monde ,"
        "5 site info politique,6 site info Economique peut choisir un source il suffit de demande le numero de source ";
    await s.speak(text, "fr-FR");
  }

  Future<void> updateNews() async {
    NewsControllers controllers = NewsControllers(source: "");
    NewsAPIControllers newsControllers = NewsAPIControllers();
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    final bool connected = connectivity != ConnectivityResult.none;
    if (connected) {
      print("on a fait une mise a jour");
      await controllers.readJsonApi("sport");
      await controllers.readJsonApi("acceuil_ar");
      await controllers.readJsonApi("acceuil");
      await controllers.readJsonApi("economie");
      await controllers.readJsonApi("monde");
      await newsControllers.getData();
    } else {
      print("impossible de faire mise a jour");
      await controllers.readJsonOffline();
      await newsControllers.getDataOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.newspaper_outlined ),
            ),
            SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                               // 'choisir une source ${_lastWords}',
                                'choisir une source',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.abel().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      ),
                      GridView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                        ),
                        children: [
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsList(source: "acceuil_ar",index: 4),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.text_format_sharp ,size: 60,color: Theme.of(context).primaryColor),
                                  //    FaIcon(IconData(0xf07d0, fontFamily: 'MaterialIcons')),
                                  /*Expanded(
                                    child: Image.asset(
                                      'images/politique.jpg',

                                    ),
                                  ),*/
                                  Text("الرئيسية", style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                       NewsList(source: "acceuil",index: 2),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.star_sharp,size: 60,color: Theme.of(context).primaryColor),
                                 /* Expanded(
                                    child: Image.asset(
                                      'images/acceuil.PNG',

                                    ),
                                  ),*/
                                  Text("Acceuil", style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsList(source: "sport",index: 1),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.sports_basketball_outlined,size: 60,color: Theme.of(context).primaryColor),
                                  /*Expanded(
                                    child: Image.asset(
                                      'images/Sport.PNG',
                                    ),
                                  ),*/
                                  Text("Sport", style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsList(source: "monde",index: 3),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.public,size: 60,color: Theme.of(context).primaryColor),
                                /*  Expanded(
                                    child: Image.asset(
                                      'images/monde.webp',
                                    ),
                                  ),*/
                                  Text("Monde", style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsList(source: "economie",index: 5),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.insert_chart,size: 60,color: Theme.of(context).primaryColor),
                                 /* Expanded(
                                    child: Image.asset(
                                      'images/economique.jpg',

                                    ),
                                  ),*/
                                  Text("Economique", style: TextStyle(fontSize: 18),)
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsPage(),
                                  ));
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.api,size: 60,color: Theme.of(context).primaryColor),
                                  /*Expanded(
                                    child: Image.asset(
                                      'images/Sport.PNG',
                                    ),
                                  ),*/
                                  Text("ApiNews", style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      /*   floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: lecture,
              child: isPlaying ? Icon(
                Icons.stop,
                size: 40,
                color: Colors.white,
              )
                  : Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
              heroTag: null,
            ),
            FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: updateNews,
            child:  Icon( Icons.update_outlined,
              size: 40,
              color: Colors.white,
            ),
            heroTag: null,
          ),
            AvatarGlow(
              animate: isListening,
              endRadius: 75,
              glowColor: Theme.of(context).primaryColor,
              child: FloatingActionButton(
                child: Icon(
                    _speechToText.isNotListening ? Icons.mic_off : Icons.mic, size: 36),
                onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
                //heroTag: null,
              ),
            ),
          ]
      ),*/
      floatingActionButton: AvatarGlow(
        //animate: isListening,
        endRadius: 30,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,
              size: 36),
          onPressed:
          _speechToText.isNotListening ? _startListening : _stopListening,
          //heroTag: null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: lecture,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isPlaying
                            ? Icon(
                          Icons.stop_circle_outlined,
                          size: 40,
                          color: Colors.grey,
                        )
                            : Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: _selectedIndex == 0
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        Text(
                          'lecture',
                          style: TextStyle(
                            color:
                            _selectedIndex == 0 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: updateNews,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.update_outlined,
                          size: 40,
                          color:
                          _selectedIndex == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'mise_a_jour',
                          style: TextStyle(
                            color:
                            _selectedIndex == 1 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
