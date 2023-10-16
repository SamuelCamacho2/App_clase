import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/profesor_model.dart';
import 'package:my_app/screens/add_carrera.dart';
import 'package:my_app/screens/add_profesor.dart';
 
class CardProfesor extends StatefulWidget {
  CardProfesor({super.key, required this.profesorModel, this.tareaDB});

  ProfesorModel profesorModel;
  TareaDB? tareaDB;

  @override
  State<CardProfesor> createState() => _CardProfesorState();
}

class _CardProfesorState extends State<CardProfesor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.amber),
      child: Row(
        children: [
          Column( 
            children: [
              Text(widget.profesorModel.nombreProfe!),
              Text(widget.profesorModel.email!),
              FutureBuilder<String>(
                  future: widget.tareaDB!.nombreCarrera(widget.profesorModel.idCarrera!),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}');
                      }
                    }
                  })
              // Text(profesorModel.idCarrera.toString()),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
                  GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProfesor(profesorModel: widget.profesorModel,)
                  )
                ),
                child: const Icon(Icons.edit),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Mensaje del sistema'),
                          content: const Text('¿Deseas borrar la Carrera?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                widget.tareaDB!
                                    .Delete('tblProfesor',
                                        widget.profesorModel.idProfesor!, 'idprofesor')
                                    .then((value) {
                                  Navigator.pop(context);
                                  GlobalValues.flagtask.value =
                                      !GlobalValues.flagtask.value;
                                });
                              },
                              child: const Text('Si'),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
