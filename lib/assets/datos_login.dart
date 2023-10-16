
import 'package:shared_preferences/shared_preferences.dart';

class InicioSesio{

  String? user;
  String? pass;
  bool? sesion;

  InicioSesio({required this.user, required this.pass, required this.sesion});

  guardarUsuario()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuario', user!);
    prefs.setString('contrasena', pass!);
    prefs.setBool('sesion', sesion!);
  }

  leerUsuario()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString('usuario');
    pass = prefs.getString('contrasena');
    sesion= prefs.getBool('sesion') ?? false;
  }

  borrarDatos()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usuario');
    prefs.remove('contrasena');
    prefs.remove('sesion');
  }
}