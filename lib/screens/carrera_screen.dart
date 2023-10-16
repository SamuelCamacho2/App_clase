import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/carrera_model.dart';
import 'package:my_app/widgets/cardCarrera.dart';

class Carrera_Screen extends StatefulWidget {
  const Carrera_Screen({super.key});

  @override
  State<Carrera_Screen> createState() => __Carrera_ScreenState();
}

class __Carrera_ScreenState extends State<Carrera_Screen> {
  TareaDB? tareaDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tareaDB = TareaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carreras'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addCarrera')
              .then((value){
                setState(() {});
              }
            ), 
            icon: const Icon(Icons.task)
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagtask,
        builder: (context, value, _) {
          return FutureBuilder(
            future: tareaDB!.ListarCarrera(),
            builder: (BuildContext context, AsyncSnapshot<List<CarreraModel>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index ){
                    return CardCarrera(
                      carreraModel: snapshot.data![index],
                      tareaDB: tareaDB,
                    );
                  }
                  );
              }else{
                if( snapshot.hasError ){
                  return const Center(
                    child: Text('Error!'),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              }
            }
            );
        },
      ),
    );
    
  }
}