import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/agenddb.dart';
import 'package:my_app/models/task_model.dart';
import 'package:my_app/screens/add_task.dart';


// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  CardTaskWidget(
    {super.key,required this.taskModel,
    this.agendaDB}
  );

  TaskMolde taskModel;
  AgendaDB? agendaDB;

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
              Text(taskModel.nametask!),
              Text(taskModel.dscTask!)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask()
                  )
                ),
                child: const Icon(Icons.edit)
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Mensaje del sistema'),
                        content: const Text('¿Deseas borrar la Carrera?'),
                        actions: [
                          TextButton(onPressed:(){
                            agendaDB!.Delete('tblTareas', taskModel.idTask!)
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

// class CardTaskWidget extends StatelessWidget {
//   CardTaskWidget({super.key, this.taskMoldel, this.agendaDB});

//   TaskMolde? taskMoldel;
//   AgendaDB? agendaDB;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(top: 10),
//       decoration: const BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Text(taskMoldel!.nametask!),
//               Text(taskMoldel!.dscTask!),
//               Text(taskMoldel!.sttTask!),
//             ],
//           ),
//           Expanded(child: Container()),
//           Column(
//             children: [
//               GestureDetector(
//                   onTap: () =>  Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AddTask(
//                               taskMoldel: taskMoldel,
//                             )),
//                   ),
//                   child: Image.asset(
//                     'assets/images/pendiente.png',
//                     height: 50,
//                   )),
//               IconButton(
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text('Eliminar'),
//                             content: Text('¿Desea eliminar la tarea?'),
//                             actions: [
//                               TextButton(onPressed: () {agendaDB!.Delete('tblTarea', 
//                               TaskMolde.idTask!).then((value) { 
//                                 Navigator.pop(context); 
//                                 GlobalValues.flagtask.value = false;
//                                 }
//                               );
//                               }, 
//                               child: Text('Si')),
//                               TextButton(onPressed: () => Navigator.pop(context), child: Text('No'))
//                             ],
//                           );
//                         });
//                   },
//                   icon: Icon(Icons.delete))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }