import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFEA1433);
const Color secondaryColor = Color(0xFF04A912);
const Color accentColor = Color(0x00EBFFEB);
const Color yellowTheme = Color(0x00fec31a);
const Color orangeTheme = Color(0xFFF36A14);
const Color greyBackgroundTextField = Color(0xFAFAFAEF);

const TextStyle headText1 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);

const TextStyle headText2 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black);

const TextStyle descText = TextStyle(fontSize: 12, color: Colors.grey);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.inter(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.inter(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.inter(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.inter(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.15),
  subtitle1: GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.inter(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.inter(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: secondaryColor,
      background: Colors.white),
  textTheme: myTextTheme,
  primarySwatch: Colors.lightBlue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      background: Colors.black),
  textTheme: myTextTheme,
  primarySwatch: Colors.lightBlue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);
