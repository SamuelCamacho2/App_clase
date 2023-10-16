import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/profesor_model.dart';
import 'package:my_app/widgets/cardPorf.dart';

class Profesor_carrera extends StatefulWidget {
  const Profesor_carrera({super.key});

  @override
  State<Profesor_carrera> createState() => _Profesor_carreraState();
}

class _Profesor_carreraState extends State<Profesor_carrera> {
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
        title: const Text('Profesores'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addProfesor')
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
            future: tareaDB!.ListarProfesor(), 
            builder: (BuildContext context, AsyncSnapshot<List<ProfesorModel>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index ){
                    return CardProfesor(
                      profesorModel: snapshot.data![index],
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            });
        },
      ),
    );
  }
}