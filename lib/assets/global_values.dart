import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalValues {
  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(false);
  static ValueNotifier<bool>  flagtask = ValueNotifier<bool>(true);
  
  guardarValor(valor) async{
    flagTheme.value = valor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('flagTheme', flagTheme.value);
  }

  leerValor() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    flagTheme.value = prefs.getBool('flagTheme') ?? false;
  }
}