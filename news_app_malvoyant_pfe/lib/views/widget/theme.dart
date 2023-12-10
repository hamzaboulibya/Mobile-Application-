import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';


const COLOR_PRIMARY = Colors.deepOrangeAccent;
const COLOR_ACCENT = Colors.orange;
Color _primaryColor = HexColor('#041e42');
Color _accentColor = HexColor('#16a2cb');

class ThemeService {
  ///Themes
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
   //   primaryColor: Colors.blueGrey.shade300,
      appBarTheme: const AppBarTheme(),
      dividerColor: Colors.white,
  );

      ///changeement//
     /* elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT))),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1)));*/

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: _primaryColor,
    accentColor: _accentColor,
    appBarTheme: const AppBarTheme(),
    dividerColor: Colors.white54,
    ///chae///
    /*brightness: Brightness.dark,
    accentColor: Colors.redAccent,
    cardColor: Colors.red,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.blue),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)),*/
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          //  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            overlayColor: MaterialStateProperty.all<Color>(Colors.blue))),
  );

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}