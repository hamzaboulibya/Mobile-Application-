import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../controllers/apinews_controllers.dart';
import '../../controllers/news_controllers.dart';
import '../../models/newsapi_model.dart';
import '../../api/text_to_speech.dart';
import '../widget/drawer.widgets.dart';
import '../widget/theme.dart';
import 'content_new_api.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String titleTest="hello";
  bool isPlaying=true;
  bool isListening = false;
  Speech speech=new Speech();
  List articlesNews=[];
  dynamic articles;
  late String currentTtsString;
  late double currentSpeechRate;
  double ttsSpeechRate1 = 0.5;
  int _selectedIndex = 0;
  bool _speechEnabled = false;
  String _lastWords = '';
  SpeechToText _speechToText = SpeechToText();

  @override
  initState() {
    super.initState();
    _initSpeech();
    getNewsElements();
    // initTts();
  }
  TtsState ttsState = TtsState.playing;

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult,
      listenFor: Duration(seconds: 120),
      pauseFor: Duration(seconds: 120),);
    setState(() {
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.



  Future _speak(dynamic text, String lang) async{
    //  await speech.flutterTts.setVoice({"name": "Karen", "locale": lang});
    await speech.flutterTts.awaitSpeakCompletion(true);
    await speech.flutterTts.setLanguage(lang);
    speech.speak(text,'an-AN');
    setState(() {
      isPlaying= true;
    });
  }

  Future stop() async {
    var result = await speech.flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying=false;
        ttsState = TtsState.stopped;
      });
    //setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await speech.flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  Future<void> getNewsElements() async {
    NewsAPIControllers  controllers=NewsAPIControllers();
    articles= await controllers.getDataOffline();
    for(int i=0;i<articles.articles.lenght;i++){
      articlesNews.add('titre ${i} ${articles.articles[i].title}');
    }
    setState(() {
      isPlaying= true;
    });
    for(int i=0;i<articlesNews.length;i++){
      currentTtsString=articlesNews[i];
      print(currentTtsString);
      currentSpeechRate = ttsSpeechRate1;
      await runTextToSpeech(currentTtsString, currentSpeechRate);
      print('### ${articlesNews[i]}');
    }
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (_lastWords.contains("pause")) {
        print("ana f comd pause");
        lecture();
      }
      if (_lastWords.contains("lire")) {
        print("ana f comd lire");
        lecture();
      }

      for (int i = 0; i < articlesNews.length; i++) {
        if (_lastWords.contains("${(i + 1)}")) {
          print(_lastWords);
          stop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GetArticlesAPIConetent(articles: articles.news,
                        source: '',
                        index: i,)));
        }
      }
    });
  }

      Future<void> runTextToSpeech(String currentTtsString, double currentSpeechRate) async {
        FlutterTts flutterTts;
        flutterTts = new FlutterTts();
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.setLanguage("fr-FR");
        await flutterTts.setVolume(1.0);
        await flutterTts.setPitch(1.0);
        await flutterTts.isLanguageAvailable("fr-FR");
        await flutterTts.setSpeechRate(currentSpeechRate);
        await flutterTts.speak(currentTtsString);
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
          /*      _selectedIndex=0;
          if(widget.index==0){
            print("c'est le premier element");
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
          }
          else{
            _stop();
            widget.index--;
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
          }
          print(_selectedIndex);*/
        });
      }

      void suivant() {
        setState(() {
          /*       _selectedIndex=1;
          if(widget.index==widget.articles.length-1){
            print("c'est le dernier element");
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
          }
          else{
            print("l'id de liste: ${_selectedIndex}");
            _stop();
            widget.index++;
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
          }
*/
        });
      }

      void lecture() {
        setState(() {
          //speechSettings1();
          //   isPlaying ? _stop() : _speak("Bonjour tout le monde ");
          // isPlaying ? _stop(): _speak("${widget.content}");
          isPlaying ? stop() : getNewsElements();
        });
      }

      @override
      void dispose() {
        super.dispose();
        speech.flutterTts.stop();
      }

      @override
      Widget build(BuildContext context) {
        NewsAPIControllers controllers = Get.put(NewsAPIControllers());
        return Directionality(
          textDirection: TextDirection.ltr,
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
              future: controllers.getDataOffline(),
              builder: (context, AsyncSnapshot snapshot) {
                Articles data = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: data.articles.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                GetArticlesAPIConetent(articles: data.articles,
                                    source: '',
                                    index: index))
                              /*MaterialPageRout()
                              builder: (context) => GetNewsConetent(image: data.articles[index].urlToImage.toString(), content: data.articles[index].content.toString(),
                                title:data.articles[index].title.toString(),date: data.articles[index].publishedAt.toString(),source:data.articles[index].source.name.toString())));*/
                            );
                            //flutterTts.speak(x);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.only(
                                left: 12.0, right: 8, top: 15, bottom: 15),
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
                                  data.articles[index].title,
                                  style: GoogleFonts.lato(
                                    textStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .headline4,
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
                                    data.articles[index].description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: GoogleFonts
                                          .montserrat()
                                          .fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AvatarGlow(
                      animate: isListening,
                      endRadius: 75,
                      glowColor: Theme
                          .of(context)
                          .primaryColor,
                      child: FloatingActionButton(
                        child: Icon(
                            _speechToText.isNotListening ? Icons.mic_off : Icons
                                .mic, size: 36),
                        onPressed: _speechToText.isNotListening
                            ? _startListening
                            : _stopListening,
                        //heroTag: null,
                      ),
                    ),
                  ]
              ),
            /*floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [FloatingActionButton(
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
                  AvatarGlow(
                    animate: isListening,
                    endRadius: 75,
                    glowColor: Theme
                        .of(context)
                        .primaryColor,
                    child: FloatingActionButton(
                      child: Icon(
                          _speechToText.isNotListening ? Icons.mic_off : Icons
                              .mic, size: 36),
                      onPressed: _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,
                      //heroTag: null,
                    ),
                  ),
                ]
            ),*/
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                          onPressed: precedent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.navigate_before_outlined,
                                color: _selectedIndex == 0
                                    ? Colors.blue
                                    : Colors.grey,

                              ),
                              Text('precedent', style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Colors.blue
                                    : Colors.grey,
                              ),)
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
                              Icon(Icons.navigate_next_outlined,
                                color: _selectedIndex == 1
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              Text('suivant', style: TextStyle(
                                color: _selectedIndex == 1
                                    ? Colors.blue
                                    : Colors.grey,
                              ),)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
}



