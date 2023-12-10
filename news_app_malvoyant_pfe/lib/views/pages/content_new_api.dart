import 'package:news_app_malvoyant_pfe/models/newsapi_model.dart';
//import 'package:news_app_malvoyant_pfe/views/pages/setting.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:application_pfe_malvoyant/views/widget/floating_action_button.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import '../../api/SpeechApi.dart';
//import '../../models/hespress_model.dart';
//import '../../utils.dart';
import '../../api/text_to_speech.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class GetArticlesAPIConetent extends StatefulWidget {
  /* String content;
  String image;
  String title;
  String date;
  String source;*/
  //NewsElement article;
  List<dynamic> articles;
  int index;
  String source;

  GetArticlesAPIConetent(
      {required this.articles, required this.source, required this.index});

  /* GetNewsConetent({required this.image,required this.content, required this.title,
    required this.date,required this.source});*/

  @override
  State<GetArticlesAPIConetent> createState() =>
      GetArticlesAPIConetentState(articles[index]);
}

class GetArticlesAPIConetentState extends State<GetArticlesAPIConetent> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = true;
  dynamic article;
  bool isListening = false;
  String titleTest = "hello";
  GetArticlesAPIConetentState(Article article) {
    this.article = article;
    /* AlanVoice.addButton("38ca5bffb91c02ad4b03bbb0d49c901b2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));*/
  }
  // GetNewsConetentState({required this.article});
  int _selectedIndex = 0;

  Speech speech = new Speech();
  TtsState ttsState = TtsState.playing;
 /* Setting setting = Setting(
    volume: 0.5,
    pitch: 1.0,
    rate: 0.5,
  );*/
  bool _speechEnabled = false;
  String _lastWords = '';
  SpeechToText _speechToText = SpeechToText();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
    /*flutterTts.setVolume(setting.volume);
    flutterTts.setSpeechRate(setting.rate);
    flutterTts.setPitch(setting.pitch);*/
    flutterTts.setLanguage('fr-FR');
    // flutterTts.speak("${widget.content}");
    flutterTts.speak("${article.content}");
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
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (_lastWords.contains("pause")) {
        print("ana f comd pause");
        lecture();
      }
      if (_lastWords.contains("lire")) {
        print("ana f cmd lire");
        lecture();
      }
      if (_lastWords.contains("suivant")) {
        print("ana f cmd suivant");
        suivant();
      }
      if (_lastWords.contains("précédent")) {
        print("ana f cmd precedent");
        precedent();
      }
    });
    _lastWords = '';
  }

  Future _speak(dynamic text) async {
    flutterTts.speak(text);
    setState(() {
      isPlaying = true;
    });
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
    //setState(() => ttsState = TtsState.stopped);
  }

  void precedent() {
    setState(() {
      _selectedIndex = 0;
      if (widget.index == 0) {
        print("c'est le premier element");
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
      } else {
        _stop();
        widget.index--;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GetArticlesAPIConetent(
                    articles: widget.articles,
                    source: widget.source,
                    index: widget.index)));
      }
      print(_selectedIndex);
    });
  }

  void suivant() {
    setState(() {
      _selectedIndex = 1;
      if (widget.index == widget.articles.length - 1) {
        print("c'est le dernier element");
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => GetNewsConetent(articles: widget.articles, source: widget.source, index: widget.index)));
      } else {
        print("l'id de liste: ${_selectedIndex}");
        _stop();
        widget.index++;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GetArticlesAPIConetent(
                    articles: widget.articles,
                    source: widget.source,
                    index: widget.index)));
      }
    });
  }

  void lecture() {
    setState(() {
      //speechSettings1();
      //   isPlaying ? _stop() : _speak("Bonjour tout le monde ");
      // isPlaying ? _stop(): _speak("${widget.content}");
      isPlaying ? _stop() : _speak("${article.content}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _speechToText.isNotListening ? 'NewsApi' : '${_lastWords}',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            // child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Divider(
                        height: 80,
                        color: Color(0xffFF8A30),
                        thickness: 20,
                      ),
                      Text(
                        '${article.publishedAt}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${article.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      wordSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${article.publishedAt.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //let's add the height

                      image: DecorationImage(
                          image:
                              NetworkImage("${article.urlToImage.toString()}"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${article.description.toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      wordSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // floatingAction.FloatingActionButton(),
                ],
              ),
            ),
          ),
          // ),
        ),
        // floatingActionButton: floatingAction.FloatingActionButton(),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              heroTag: null,
            ),
          ),
        ]),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
