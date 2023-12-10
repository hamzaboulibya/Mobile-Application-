import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import '../../api/text_to_speech.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListening = false;
  String _lastWords = '';
  bool _speechEnabled = false;
  SpeechToText _speechToText = SpeechToText();
  Speech speech = new Speech();
  String text1="Bienvenu sur votre application";
  String text2="Dans l\'application vous pouvez choisir une source ou une actualité avec des commandes vocales simplement mentionner le numéro de source ou d'actualités.";
  String text4='Parmi les commandes vocals il y a \'PAUSE\' pour arréte la lecture  \'LIRE\' pour demarer la lecture,  \'SUIVANT\' '
      'pour passe à l\'actualités ou source suivant et  \'Precedent\',';
  String text5='l\'actualité est entre vos mains maintenant';
  String text="YourNews est une application mobile pour suivre l'actualité,"
      "Grâce à YourNews, les personnes déficientes visuelles peuvent voir l'actualité de manière très simple,"
      " de n\'importe où grâce à votre smartphone, et aussi vous permet de contrôler les différentes interfaces et fonctions"
      " à l\'aide des commandes vocales";
  @override
  initState() {
    super.initState();
    speech.stop();
    _initSpeech();
    speak();
  }

  Future speak() async{
    await speech.speak(text1,'fr-FE');
  //  await speech.speak('l\'actualité est entre vos mains maintenant', 'fr-FE');
    await speech.speak(text, 'fr-FE');
    await speech.speak(text2, 'fr-FE');
    await speech.speak(text4, 'fr-FE');
    await speech.speak(text5, 'fr-FE');
  }
  Future stop() async {
    await speech.stop();
  }

  @override
  void dispose() {
    super.dispose();
    speech.flutterTts.stop();
  }


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
      if (_lastWords.contains("commencer")) {
        print("ana f comd commencer");
        setState(() {
            stop();
            Navigator.of(context).pushNamed('/source');
        });
      }
    });
    _lastWords = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 70,right: 0,bottom: 0),
            child: Container(
              alignment: Alignment.center,
              child: Row(
                  children:[ Container(
                    width: 140,
                    height: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/LogoYourNewsDark.png'),
                      ),
                    ),
                  ),
                  ]),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${text1}',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.ubuntu().fontFamily,
                fontWeight: FontWeight.bold,color: Theme.of(context).accentColor,),
            ),
            SizedBox(
              width: 320,
              child: Divider(
                height: 2,
                thickness: 2,
                color: Theme.of(context).accentColor,),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 360,
              child: Text('${text}',
                style: TextStyle(
                    fontSize: 16,fontFamily:GoogleFonts.andika().fontFamily ),
              ),
            ),
            SizedBox(
              width: 360,
              child: Text('${text2}',
                style: TextStyle(
                    fontSize: 16,fontFamily:GoogleFonts.andika().fontFamily ),
              ),
            ),
            SizedBox(
              width: 360,
              child: Text('${text4}',
                style: TextStyle(
                    fontSize: 16,fontFamily:GoogleFonts.andika().fontFamily ),
              ),
            ),
            SizedBox(
              width: 360,
              child: Text('${text5}',
                style: TextStyle(
                    fontSize: 16,fontFamily:GoogleFonts.andika().fontFamily ),
              ),
            ),
          ]),

          SizedBox(
           // height: 40,
            width: 200,
            child: ElevatedButton(
              onPressed: (){
                stop();
                Navigator.of(context).pushNamed('/source');
              },
              child:Row (mainAxisAlignment: MainAxisAlignment.center,
                children:[Text('Commencer'),Icon(Icons.arrow_forward,color: Colors.white,size: 30,),]),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                shape: StadiumBorder(),
              ),),
          )
        ]),
      ),
      floatingActionButton:  FloatingActionButton(
            child: Icon(
                _speechToText.isNotListening ? Icons.mic_off : Icons.mic, size: 36),
           onPressed: _speechToText.isNotListening
                ? _startListening
                : _stopListening,
            backgroundColor: Theme.of(context).accentColor,
            //heroTag: null,
      ),
    );
  }
}