import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/agenddb.dart';
import 'package:my_app/models/task_model.dart';
import 'package:my_app/widgets/cardTask_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/add')
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
        builder: (context,value,_) {
          return FutureBuilder(
            future: agendaDB!.GETALLTASK(),
            builder: (BuildContext context, AsyncSnapshot<List<TaskMolde>> snapshot){
              if( snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardTaskWidget(
                      taskModel: snapshot.data![index],
                      agendaDB: agendaDB,
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
}