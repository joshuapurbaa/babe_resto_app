import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color blackColor = Color(0xFF000000);
Color whiteColor = Color(0xFFFFFFFF);
Color redColor = Color(0xFFF54749);
Color greyColor = Color(0xFF585858);
Color yellowColor = Color(0xFFFCCC74);
Color yellowColor2 = Color(0xFFFFA600);

double defaultPadding = 16.0;

FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

final TextTheme myTextTheme = TextTheme(
  headline3: GoogleFonts.lobster(
    fontSize: 30,
    fontWeight: extraBold,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: bold,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: semiBold,
    letterSpacing: 0.2,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: semiBold,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: medium,
    letterSpacing: 0.2,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: semiBold,
    letterSpacing: 0.4,
  ),
  bodyText1: GoogleFonts.poppins(
    fontWeight: medium,
    fontSize: 15,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 12,
  ),
  button: GoogleFonts.poppins(
    fontWeight: semiBold,
  ),
  caption: GoogleFonts.poppins(),
);

TextStyle bottomNavText = TextStyle(
  color: greyColor,
  fontSize: 14,
  fontWeight: bold,
);

ThemeData lightTheme = ThemeData(
  primaryColorLight: Color(0xFFFFFFFF),
  secondaryHeaderColor: blackColor,
  primaryColor: yellowColor,
  accentColor: redColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.black),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    backgroundColor: yellowColor,
    selectedItemColor: whiteColor,
    unselectedItemColor: greyColor,
    unselectedLabelStyle: bottomNavText,
    selectedLabelStyle: bottomNavText,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  secondaryHeaderColor: whiteColor,
  primaryColor: yellowColor,
  accentColor: redColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.white),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    backgroundColor: greyColor,
    selectedItemColor: yellowColor,
    unselectedItemColor: Colors.grey,
    unselectedLabelStyle: bottomNavText,
  ),
);
