import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/carrera_model.dart';
import 'package:my_app/screens/add_carrera.dart';

class CardCarrera extends StatefulWidget {
  CardCarrera({super.key, required this.carreraModel, this.tareaDB});

  CarreraModel carreraModel;
  TareaDB? tareaDB;

  @override
  State<CardCarrera> createState() => _CardCarreraState();
}

class _CardCarreraState extends State<CardCarrera> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.green
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(widget.carreraModel.nomCarrera!),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCarrera(carreraModel: widget.carreraModel,),
                  )
                ),
                child: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Mensaje del sistema'),
                        content: const Text('¿Deseas borrar la tarea?'),
                        actions: [
                          TextButton(onPressed:(){
                            widget.tareaDB!.Delete('tblCarrera', widget.carreraModel.idCarrera!, 'idcarrera')
                            .then((value){
                              Navigator.pop(context);
                              GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
                            });
                          }, child: const Text('Si')),
                          TextButton(
                            onPressed:()=>Navigator.pop(context), 
                            child: const Text('No')
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete)
                )
            ],
          )
        ],
      ),
    );
  }
}