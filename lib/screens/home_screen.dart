import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle fontSize30 = const TextStyle( fontSize: 30) ;
    int counter = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        elevation: 4,
      ),

      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Numeros de clicks :', style: fontSize30 ), 
            Text('$counter', style: fontSize30)
            ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add),
        onPressed: () {
          counter++;
          print('hola mundo ' + '$counter');
        },
      ),
    );
  }
}
