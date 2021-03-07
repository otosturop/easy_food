import 'package:easy_food/components/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight _instance;
  static AppThemeLight get instance {
    if (_instance == null) _instance = AppThemeLight._init();
    return _instance;
  }

  AppThemeLight._init();
  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
      );

  ColorScheme get _appColorScheme {
    return ColorScheme(
      primary: Color(0xFFF17532), //xx
      onPrimary: Colors.orangeAccent[400], //xx
      primaryVariant: Color(0xFF545D68), //xx
      secondary: Color(0xFF575E67), //xx
      surface: Colors.white, //xx
      background: Colors.grey.shade400, //**
      onBackground: Colors.grey.shade600, //**
      error: Colors.red[900],
      onSecondary: Colors.green.shade600, //**
      onSurface: Color(0xFFCDCDCD), //**
      onError: Color(0xffffc93c),
      brightness: Brightness.light,
      secondaryVariant: Color(0xFFC88D67), //**
    );
  }
}
