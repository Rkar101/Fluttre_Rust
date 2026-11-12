import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FontConstants {
  static const String fontInter = 'Inter';
  static const String fontUbuntu = 'Ubuntu';
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
}

PreferredSize commonAppBar({text, color}) {
  return PreferredSize(
    preferredSize: Size(double.maxFinite, 50),
    child: SafeArea(
      child: AppBar(title: Text(text, style: getAppBarText(color: color))),
    ),
  );
}

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
  TextOverflow? overflow,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
    overflow: overflow,
  );
}

TextStyle getAppBarText({
  double fontSize = FontSize.s18,
  required Color color,
  TextOverflow? overflow,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontUbuntu,
    FontWeightManager.bold,
    color,
    overflow,
  );
}

TextStyle getTitleText({
  double fontSize = 16,
  required Color color,
  TextOverflow? overflow,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontInter,
    FontWeight.w500,
    color,
    overflow,
  );
}

TextStyle getMediumtext({
  double fontSize = 14,
  required Color color,
  TextOverflow? overflow,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontInter,
    FontWeight.w500,
    color,
    overflow,
  );
}

TextStyle getsmallext({
  double fontSize = 10,
  required Color color,
  TextOverflow? overflow,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontInter,
    FontWeight.w500,
    color,
    overflow,
  );
}
