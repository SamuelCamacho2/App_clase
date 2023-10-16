import 'package:flutter/material.dart';
import 'package:my_app/assets/datos_login.dart';
import 'package:my_app/screens/dashboard_screem.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String user = '';
  String pass = '';
  bool recordar = false;

  llenarCampos(){
    if(recordar){
      return true;
    }else{
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InicioSesio(user: user, pass: pass, sesion: recordar).leerUsuario();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    
    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'User',
          hintStyle: TextStyle(color: Colors.black)),
      style: const TextStyle(color: Colors.black),
    );

    final txtPass = TextField(
      controller: txtConPass,
      obscureText: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.black)),
      style: const TextStyle(color: Colors.black),
    );

    final checkSesion = CheckboxListTile(
      title: const Text('Recordar sesion', style: TextStyle(
      color: Colors.black)
      ),
        value: recordar,
        onChanged: (value) {
          setState(() {
            recordar = value!;
          });
        },
    ); 

    final imglogo = Container(
      width: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/81/81609.png'))),
    );

    final btnEntrar = FloatingActionButton.extended(
        icon: const Icon(Icons.login),
        label: const Text('Entrar'),
        onPressed: () {

          if(llenarCampos()){
            user = txtConUser.text;
            pass = txtConPass.text;
            InicioSesio(user: user, pass: pass, sesion: true ).guardarUsuario();
          }else{
            InicioSesio(user: user, pass: pass, sesion: false ).borrarDatos();
          }
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
        }
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://img.freepik.com/vector-gratis/fondo-pantalla-iphone-nube-lindo-vector-patron-clima-lluvioso_53876-144609.jpg?w=360&t=st=1693259390~exp=1693259990~hmac=5e610f39aea031e4bc368415dc4d9c40bbfabe3065cb43d9364ed7e191d17246'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 300,
                // color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass,
                    checkSesion
                  ],
                ),
              ),
              imglogo
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
