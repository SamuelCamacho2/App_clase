import 'package:flutter/material.dart';

class StyleApp {
  
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(255, 255, 0, 0),
      )
    );
  }

  static ThemeData darktheme(BuildContext context){
    final theme = ThemeData.dark(); 
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary:const Color.fromARGB(255, 50, 10, 10),
      )
    );
  }
}