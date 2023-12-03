import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/agenddb.dart'; 
import 'package:my_app/models/task_model.dart';


// ignore: must_be_immutable
class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskMoldel});

  TaskMolde? taskMoldel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  
  String? dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = [
      'Pendiente',
      'Completado',
      'En proceso'
  ];


  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if( widget.taskMoldel != null ){
      txtConName.text = widget.taskMoldel!.nametask!;
      txtConDsc.text = widget.taskMoldel!.dscTask!;
      switch(widget.taskMoldel!.sttTask){
        case 'E': dropDownValue = "En proceso"; break;
        case 'C': dropDownValue = "Completado"; break;
        case 'P': dropDownValue = "Pendiente";
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    

    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
        label: Text('Nombre de la tarea'),
        border: OutlineInputBorder()
      ),
      controller:  txtConName,
    );

    final txtDscTask = TextField(
      decoration: const InputDecoration(
        label: Text('Descripción de la tarea'),
        border: OutlineInputBorder()
      ),
      maxLines: 6,
      controller:  txtConDsc,
    );

    const space =  SizedBox(height: 10);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(), 
      onChanged: (value){
        dropDownValue = value;
        setState(() { });
      }
    );

      final ElevatedButton btnGuardar = 
      ElevatedButton(
        onPressed: (){
          if( widget.taskMoldel == null ){
            agendaDB!.INSERT('tblTareas', {
              'nameTask' : txtConName.text,
              'dscTask' : txtConDsc.text,
              'sttTask' : dropDownValue!.substring(0,1)
            }).then((value){
              var msj = ( value > 0 ) 
                ? 'La inserción fue exitosa!'
                : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } 
          else{
            agendaDB!.UPDATE('tblTareas', {
              'idTask' : widget.taskMoldel!.idTask,
              'nameTask' : txtConName.text,
              'dscTask' : txtConDsc.text,
              'sttTask' : dropDownValue!.substring(0,1)
            }).then((value) {
              GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
              var msj = ( value > 0 ) 
                ? 'La actualización fue exitosa!'
                : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        }, 
        child: const Text('Save Task')
      );

    return Scaffold(
      appBar: AppBar(
        title: widget.taskMoldel == null 
          ? const Text('Add Task')
          : const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}