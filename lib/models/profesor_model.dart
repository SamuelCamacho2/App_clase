class ProfesorModel {
  
  int? idProfesor;
  String? nombreProfe;
  int? idCarrera;
  String? email;

  ProfesorModel({this.idProfesor, this.nombreProfe, this.idCarrera, this.email});

  factory ProfesorModel.fromMap(Map<String, dynamic> map){
    return ProfesorModel(
      idProfesor: map['idprofesor'],
      nombreProfe: map['nomprofe'],
      idCarrera: map['idcarrera'],
      email: map['email'],
    );
  }

}