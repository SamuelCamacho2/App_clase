import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/assets/styles.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/dashboard_screem.dart';


//SCREENS
import 'package:my_app/screens/login_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool sesion = prefs.getBool('sesion') ?? false;
  runApp(MyApp(sesion: sesion));
}

@immutable
class MyApp extends StatefulWidget {
  final bool sesion;
  const MyApp({super.key, required this.sesion});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    GlobalValues().leerValor();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value,_) {
        return MaterialApp( 
          debugShowCheckedModeBanner: false,
          home: widget.sesion ? const DashboardScreen() : const LoginScreen(),
          routes: getRoutes(),
          theme: value 
              ? StyleApp.darktheme(context)
              : StyleApp.lightTheme(context)
          );
      }
    ) ;
  }
}