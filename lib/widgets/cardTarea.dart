import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/tarea_model.dart';
import 'package:my_app/screens/add_tarea.dart';

class CardTarea extends StatefulWidget {
  CardTarea({super.key, required this.tareaModelo, this.tareaDB});

  TareaModelo?  tareaModelo;
  TareaDB? tareaDB;

  @override
  _CardTareaState createState() => _CardTareaState();
}

class _CardTareaState extends State<CardTarea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.blueGrey
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(widget.tareaModelo!.nombreTarea!),
                Text(widget.tareaModelo!.descripcionTarea!),
                Text('Estado : ${widget.tareaModelo!.realizada == 1 ? 'Realizada' : 'Pendiente'}'),
                Text('FECHA ENTREGA: ${widget.tareaModelo!.fecExpiracion!}'),
                Text('FECHA RECORDATORIO: ${widget.tareaModelo!.fecRecordatorio!}'),
                FutureBuilder<String>(
                  future: widget.tareaDB!.nombreProfe(widget.tareaModelo!.idProfesor!),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{
                      if(snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }else{
                        return Text('Profesor: ${snapshot.data}');
                      }
                    }
                  }
                )
              ],
            ),
          ),
          Column(
            children: [
              
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTarea(tareaModelo: widget.tareaModelo,)
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
                        content: const Text('¿Deseas borrar la Tarea?'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              widget.tareaDB!.Delete('tblTareas', widget.tareaModelo!.idTarea!, 'idtarea')
                              .then((value){
                                Navigator.pop(context);
                                GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
                              });
                            }, 
                            child: const Text('Si')
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, 
                            child: const Text('No')
                          )
                        ],
                      );
                    }
                  );
                }, 
                icon: const Icon(Icons.delete)
              ),
            ],
          )
        ],
      ),
    );
  }
}