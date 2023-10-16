import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/carrera_model.dart';
import 'package:my_app/models/profesor_model.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesorModel});

  ProfesorModel? profesorModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  TextEditingController txtProfeNom = TextEditingController();
  TextEditingController txtProEmail = TextEditingController();
  CarreraModel? carreraModel;
  List<CarreraModel> listCarrera = [];

  TareaDB? tareaDB;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    tareaDB = TareaDB();
    _getcarreras();


    if (widget.profesorModel != null) {
      txtProfeNom.text = widget.profesorModel!.nombreProfe!;
      txtProEmail.text = widget.profesorModel!.email!;
    }
  }

  _getcarreras()async{
    listCarrera = await tareaDB!.ListarCarrera();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      decoration: const InputDecoration(
          label: Text('Nombre del profesor'), border: OutlineInputBorder()),
      controller: txtProfeNom,
    );

    final txtCorre = TextFormField(
      decoration: const InputDecoration(
          label: Text('Correo del profesor'), border: OutlineInputBorder()),
      controller: txtProEmail,
    );

    const space = SizedBox(
      height: 10,
    );
    
    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.profesorModel == null) {
            tareaDB!.INSERT('tblProfesor', {
              'nomprofe': txtProfeNom.text,
              'email': txtProEmail.text,
              'idcarrera': carreraModel!.idCarrera,
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
                    'tblProfesor',
                    {
                      'idprofesor': widget.profesorModel!.idProfesor,
                      'nomprofe': txtProfeNom.text,
                      'email': txtProEmail.text,
                    },
                    'idprofesor', widget.profesorModel!.idProfesor!)
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

    final ddCarrera = DropdownButton<CarreraModel>(
      value: carreraModel,
      items: listCarrera.map((CarreraModel carrera){
        return DropdownMenuItem<CarreraModel>(
          value: carrera,
          child: Text(carrera.nomCarrera!),
        );
      }).toList(),
      onChanged: (CarreraModel? value){
        setState(() {
          carreraModel = value;
        });
      }
      );

    return Scaffold(
      appBar: AppBar(
        title: widget.profesorModel == null
            ? const Text('Agregar profesro')
            : const Text('Editar profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [txtNombre, space, txtCorre, space, ddCarrera ,space ,btnGuardar],
        ),
      ),
    );
  }
}
