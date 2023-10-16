import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/tarea_model.dart';
import 'package:my_app/widgets/cardTarea.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});
  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  TareaDB? tareaDB;
  String filtro = 'Todas';
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
        title: const Text('Listas de Tareas'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/AddTarea')
              .then((value){
                setState(() {});
              }
            ), 
            icon: const Icon(Icons.task)
          ),
          DropdownButton<String>(
            value: filtro,
            icon: const Icon(Icons.filter_list),
            onChanged: (String? newValue) {
              setState(() {
                filtro = newValue!;
              });
            },
            items: <String>['Todas', 'Completadas', 'No completadas']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagtask,
        builder: ( context,  value, _) {
          return FutureBuilder(
            future: _getTareas(),
            builder: (BuildContext context, AsyncSnapshot<List<TareaModelo>> snapshot){
              if( snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardTarea(
                      tareaModelo: snapshot.data![index],
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
        }
      ),
    );
  }
  Future<List<TareaModelo>> _getTareas() {
    switch (filtro) {
      case 'Completadas':
        return tareaDB!.ListarTareasRealizadas();
      case 'No completadas':
        return tareaDB!.ListarTareasPendientes();
      default:
        return tareaDB!.ListarTareas();
    }
  }
}