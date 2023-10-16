import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/profesor_model.dart';
import 'package:my_app/models/tarea_model.dart';

class AddTarea extends StatefulWidget {
  AddTarea({super.key, this.tareaModelo});

  TareaModelo? tareaModelo;

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  TextEditingController txttitulo = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtfecha = TextEditingController();
  TextEditingController txtFechaExpiracion = TextEditingController();
  ProfesorModel? profesorModel;
  List<ProfesorModel> listCarrera = [];
  bool tareaRealizada = false;

  
  TareaDB? tareaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tareaDB = TareaDB();
    _getPorfesores();

    if (widget.tareaModelo != null) {
      txttitulo.text = widget.tareaModelo!.nombreTarea!;
      txtdesc.text = widget.tareaModelo!.descripcionTarea!;
      txtfecha.text = widget.tareaModelo!.fecExpiracion!;
      txtFechaExpiracion.text = widget.tareaModelo!.fecRecordatorio!;
    }
  }

  _getPorfesores()async{
    listCarrera = await tareaDB!.ListarProfesor();
    setState(() {
    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // Un año después de hoy
    );
    if (picked != null)
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      decoration: const InputDecoration(
          label: Text('titulo de la tarea'), border: OutlineInputBorder()),
      controller: txttitulo,
    );

    final txtDesc = TextFormField(
      decoration: const InputDecoration(
          label: Text('Descripcion'), border: OutlineInputBorder()),
      controller: txtdesc,
    );


    const space = SizedBox(
      height: 10,
    );

    final txtFechaField = TextFormField(
      controller: txtfecha,
      decoration: const InputDecoration(
        labelText: 'Fecha de expiración',
        border: OutlineInputBorder(),
      ),
      onTap: () {
        _selectDate(context, txtfecha);
      },
    );

    final check = Checkbox(
      value: tareaRealizada, 
      onChanged: (bool? value){
        setState(() {
          tareaRealizada = value!;
        });
      }
      );

    final txtFechaExpiracionField = TextFormField(
      controller: txtFechaExpiracion,
      decoration: const InputDecoration(
        labelText: 'Fecha de recordatorio',
        border: OutlineInputBorder(),
      ),
      onTap: () {
        _selectDate(context, txtFechaExpiracion);
      },
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.tareaModelo == null) {
            tareaDB!.INSERT('tblTareas', {
              'nomtarea': txttitulo.text,
              'destarea': txtdesc.text,
              'fecexpiracion': txtfecha.text,
              'fecrecordatorio': txtFechaExpiracion.text,
              'realizada': tareaRealizada ? 1 : 0,
              'idprofesor': profesorModel!.idProfesor,
            }).then((value) {
              var msj = (value > 0)
                  ? 'La inserción fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else { 
            tareaDB!
                .UPDATE(
                    'tblTareas',
                    {
                      'idtarea': widget.tareaModelo!.idTarea,
                      'nomtarea': txttitulo.text,
                      'destarea': txtdesc.text,
                      'fecexpiracion': txtfecha.text,
                      'fecrecordatorio': txtFechaExpiracion.text,
                      'realizada': tareaRealizada ? 1 : 0,
                    },
                    'idtarea', 
                    widget.tareaModelo!.idTarea!
                    )
                .then((value) {
              GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
              var msj = (value > 0)
                  ? 'La actualización fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: const Text('Save Task'));

    final ddCarrera = DropdownButton<ProfesorModel>(
      value: profesorModel,
      items: listCarrera.map((ProfesorModel carrera){
        return DropdownMenuItem<ProfesorModel>(
          value: carrera,
          child: Text(carrera.nombreProfe!),
        );
      }).toList(),
      onChanged: (ProfesorModel? value){
        setState(() {
          profesorModel = value;
        });
      }
      );

    return Scaffold(
      appBar: AppBar(
        title: widget.tareaModelo == null
            ? const Text('Agregar Tarea')
            : const Text('Editar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [ txtNombre, space, txtDesc, space, txtFechaField, space, txtFechaExpiracionField, space, ddCarrera, space,check ,space,btnGuardar],
        ),
      ),
    );
  }
}