import 'package:flutter/material.dart';
import 'package:my_app/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPassUser = TextEditingController();
  final emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuario'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: conNameUser,
          ),
          TextFormField(
            controller: conEmailUser,
          ),
          TextFormField(
            controller: conPassUser,
          ),
          ElevatedButton(onPressed: (){
            var emial = conEmailUser.text;
            var pwd = conPassUser.text;
            emailAuth.createUser(emailUser: emial, pdwUser: pwd);
          }, child: Text('Registrar'))
        ],
      ),
    );
  }
}