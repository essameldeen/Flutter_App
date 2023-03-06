import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          fontFamily: "Jannah",
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      color: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white)),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0),
  textTheme: const TextTheme(
      subtitle1: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white,height: 1.2      ),
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
);


ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: "Jannah",
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      color: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light, statusBarColor: Colors.white)),
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultColor,
      elevation: 20.0),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black,height: 1.2
    ),
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
);
