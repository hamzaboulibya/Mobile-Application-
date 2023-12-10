import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class Speech {
  FlutterTts flutterTts = FlutterTts();
  String? language;
  String? engine;
  double volume = 0.7;
  double pitch = 1;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  bool isP = false;

  String? newVoiceText;
  int? inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWeb => kIsWeb;

  Future getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future stop() async {
    await flutterTts.stop();
  }

  Future speak(dynamic text, dynamic lang) async {
    await flutterTts.setLanguage(lang);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.speak(text!);
      }
    }
  }

  Future setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}
