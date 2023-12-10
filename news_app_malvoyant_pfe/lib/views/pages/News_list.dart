import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../api/text_to_speech.dart';
import '../widget/ListeTousArticles.dart';
import '../widget/theme.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../controllers/news_controllers.dart';
import '../../models/new_models.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';
import '../widget/drawer.widgets.dart';
import 'Content.dart';

class NewsList extends StatefulWidget {
//  const HespressNews({Key? key}) : super(key: key);

  String source;
  int index;
  NewsList({required this.source, required this.index});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  FlutterTts flutterTts = FlutterTts();
  ListeTousArticles listeTousArticles = new ListeTousArticles();
  String titleTest = "hello";
  bool isPlaying = true;
  bool isListening = false;
  Speech speech = new Speech();
  List articlesNews = [];
  dynamic articles;
  late String currentTtsString;
  late double currentSpeechRate;
  double ttsSpeechRate1 = 0.5;
  int _selectedIndex = 0;
  bool _speechEnabled = false;
  String _lastWords = '';
  SpeechToText _speechToText = SpeechToText();
  //TtsState ttsState = TtsState.playing;
  dynamic sourceListe=["sport","sport","acceuil","monde","acceuil_ar","economie"];

  @override
  initState() {
    super.initState();
    _initSpeech();
    print("eawdt dkhlt hna");
    if (widget.source == "jsonFil/hespeessAr.json") {
      _speak('مرحبا في هيسبريس', 'ar');
      speakT();
    } else {
      print("<==================>avant speakT<==================>");
      //   speakT();
    }
    getNewsElements();
    // initTts();
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

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  Future _speak(dynamic text, String lang) async {
    speech.speak(text,lang);
    setState(() {
      isPlaying = true;
    });
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }

  Future _pause() async {
    var result = await speech.flutterTts.pause();
   // if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    speech.flutterTts.stop();
  }

  Future<void> getNewsElements() async {
    print("elx mkhdmx");
    setState(() {
      isPlaying = true;
    });
   NewsControllers controllers =
    NewsControllers(source: widget.source);
    articles = await controllers.readJsonOffline();
    for (int i = 0; i < articles.news.length; i++) {
      articlesNews.add('titre ${i} ${articles.news[i].title}');
    }
    for (int i = 0; i < articlesNews.length; i++) {
      currentTtsString = articlesNews[i];
      print(currentTtsString);
      await runTextToSpeech(currentTtsString);
      print('### ${articlesNews[i]}');
    }
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
        getNewsElements();
      }
      if (_lastWords.contains("suivant")) {
        print("ana f cmd suivant");
        suivant();
      }
      if (_lastWords.contains("précédent")) {
        print("ana f cmd precedent");
        precedent();
      }
      for (int i = 0; i < articlesNews.length; i++) {
        if (_lastWords.contains("${(i + 1)}")) {
          print(_lastWords);
          stop();
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetNewsConetent(
                        articles: articles.news,
                        source: widget.source,
                        index: i,
                 )));
        }
      }

      /*   if(_lastWords.contains("titre 1")){
            print(_lastWords);
            for (int i = 0; i < articlesNews.length; i++) {
            //  print(_lastWords);
              if (_lastWords.contains('titre ${i + 1}')) {
                print("ana fost boucle");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetNewsConetent(articles: articlesNews,source: widget.source,index: i,)));
              }
            }
          }*/
    });
    _lastWords = '';
  }

  Future<void> runTextToSpeech(String currentTtsString) async {
    if (widget.source == "acceuil_ar") {
      await speech.speak(currentTtsString, "ar");
    } else {
      await speech.speak(currentTtsString, "fr-FR");
    }
  }

  void speakT() {
    print(articlesNews.length);
    for (int i = 0; i < articlesNews.length; i++) {
      print("on a maintenant dans speakT");
      int trendIndex = articlesNews.indexWhere((f) => f['index'] == i);
      print(trendIndex);
      String title = articlesNews[trendIndex]['titre'];
      print(title);
      //  _speak(articlesNews[i]['titre'],'fr-FR');
    }
    //  articlesNews=[];
  }

  void precedent() {
    setState(() {
         _selectedIndex = 0;
          if(widget.index==0){
            print("c'est le premier source");
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsList(source: widget.source,index: widget.index,)));
          }
          else{
            stop();
            widget.index--;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsList( source: sourceListe[widget.index], index: widget.index)));
          }
          print(_selectedIndex);
    });
  }

  void suivant() {
    setState(() {
      _selectedIndex = 1;
          if(widget.index==sourceListe.length-1){
            print("c'est le dernier element");
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
          }
          else{
            print("l'id de liste: ${_selectedIndex}");
            stop();
            widget.index++;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsList( source: sourceListe[widget.index], index: widget.index)));
          }
    });
  }

  void lecture() {
    setState(() {
      isPlaying ? stop() : getNewsElements();
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsControllers controllers = NewsControllers(source: widget.source);
    return Directionality(
      textDirection: widget.source == "acceuil_ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  ThemeService().changeTheme();
                },
                icon: Icon(
                  Icons.dark_mode,
                ))
          ],
          title: Text('Your News'),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: controllers.readJsonOffline(),
          builder: (context, AsyncSnapshot snapshot) {
            News data = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: data.news.length,
                itemBuilder: (context, int index) =>  listeTousArticles.ListeArticle(index, widget.source, context, data.news),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.zero,
          height: 60,
          width: 60,
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),*/
          child: AvatarGlow(
               animate: isListening,
               endRadius: 75,
               glowColor: Theme.of(context).primaryColor,
               child: FloatingActionButton(
                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 child: Icon(
                 _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                 size: 36),
                onPressed: _speechToText.isNotListening
                ? _startListening
                : _stopListening,
    //heroTag: null,
             ),
          ),
        ),

       /* floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: [
            FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: lecture,
            child: isPlaying
                ? Icon(
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
          AvatarGlow(
            animate: isListening,
            endRadius: 75,
            glowColor: Theme.of(context).primaryColor,
            child: FloatingActionButton(
              child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                  size: 36),
              onPressed: _speechToText.isNotListening
                  ? _startListening
                  : _stopListening,
              //heroTag: null,
            ),
          ),
        ]),*/

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: precedent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.navigate_before_outlined,
                            color:
                                _selectedIndex == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'precedent',
                            style: TextStyle(
                              color: _selectedIndex == 0
                                  ? Colors.blue
                                  : Colors.grey,
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
                    FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: lecture,
                      child: isPlaying
                          ? Icon(
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: suivant,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.navigate_next_outlined,
                            color:
                                _selectedIndex == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'suivant',
                            style: TextStyle(
                              color: _selectedIndex == 1
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
