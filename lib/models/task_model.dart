class TaskMolde {

  int? idTask;
  String? nametask;
  String? dscTask;
  String? sttTask;

  TaskMolde({this.idTask, this.nametask, this.dscTask, this.sttTask});
  factory TaskMolde.fromMap(Map<String, dynamic> map){
    return TaskMolde(
      idTask: map['idtask'],
      dscTask: map['dscTask'],
      nametask: map['nametask'],
    );
  }

}

