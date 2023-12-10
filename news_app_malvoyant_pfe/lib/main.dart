import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_malvoyant_pfe/views/pages/SplashScreen.dart';
import 'package:news_app_malvoyant_pfe/views/pages/about.dart';
import 'package:news_app_malvoyant_pfe/views/pages/home_page.dart';
import 'package:news_app_malvoyant_pfe/views/pages/how_to_use.dart';
import 'package:news_app_malvoyant_pfe/views/pages/source_news.dart';
import 'package:news_app_malvoyant_pfe/views/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color _primaryColor = HexColor('#041e42');
Color _accentColor = HexColor('#16a2cb');

 late int? initScreen;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen= await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      themeMode: ThemeService().getThemeMode(),
       //primaryColor: _primaryColor,
      //   accentColor: _accentColor,
      initialRoute:initScreen ==0 || initScreen==null ? '/home' : '/source',
      routes: {
       // '/': (context) => SplashScreen(),
       "/home":(context)=> HomePage(),
        "/source": (context) => SourceNews(),
        "/how_to_use": (context) => HowToUse(),
        "/apropos": (context) => About(),
        /*"/update": (context) => BlurryDialog(
            "Update!!", "Merci de faire la mise a jour de votre application"),
     */ },
    );
  }
}

