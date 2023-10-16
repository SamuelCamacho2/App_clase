import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
    int counter = 15;
  @override
  Widget build(BuildContext context) {

    TextStyle fontSize30 = const TextStyle( fontSize: 30) ;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterScreen'),
        elevation: 4,
      ),

      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('cuant de clicks :', style: fontSize30 ), 
            Text('$counter', style: fontSize30)
            ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          FloatingActionButton(
            child: const Icon( Icons.plus_one_outlined),
            onPressed: () {
              counter++;
              setState(() { });
            },
          ),

          const SizedBox(width: 100,),

          FloatingActionButton(
            child: const Icon( Icons.restore_outlined),
            onPressed: () {
              counter = 0 ;
              setState(() { });
            },
          ),

          const SizedBox(width: 100,),

          FloatingActionButton(
            child: const Icon( Icons.exposure_minus_1),
            onPressed: () {
              counter--;
              setState(() { });
            },
          ),
        ],
      ),
    );
  }
}
