import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/carrera_model.dart';

// ignore: must_be_immutable
class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});

  CarreraModel? carreraModel;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {

  TextEditingController txtCarreraNom = TextEditingController();
  TareaDB? tareaDB;

  @override
  void initState(){
    super.initState();
    tareaDB = TareaDB();
    if(widget.carreraModel != null){
      txtCarreraNom.text = widget.carreraModel!.nomCarrera!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtnombre = TextFormField(
      decoration: const InputDecoration(
        label: Text('Nombre de la carrera'),
        border: OutlineInputBorder()
      ),
      controller: txtCarreraNom,
    );

    const space = SizedBox(height: 10,);
 
    final ElevatedButton btnGuardar = 
      ElevatedButton(
        onPressed: (){
          if( widget.carreraModel == null || widget.carreraModel!.idCarrera == null ){
            tareaDB!.INSERT('tblCarrera', {
              'nomcarrera' : txtCarreraNom.text
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
            tareaDB!.UPDATE(
              'tblCarrera', 
              {
              'idcarrera' : widget.carreraModel!.idCarrera,
              'nomcarrera' : txtCarreraNom.text
              }, 
              'idcarrera', 
              widget.carreraModel!.idCarrera!
            ).then((value) {
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
        child: const Text('Guardar')
      );

    return Scaffold(
      appBar: AppBar(
        title: widget.carreraModel == null 
          ? const Text('Agregar carrera')
          : const Text('Editar carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtnombre,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}