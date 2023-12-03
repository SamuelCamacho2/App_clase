class movieModel {
  int? idMovie;  
  int? validar; 

  movieModel({this.idMovie, this.validar});

  factory movieModel.fromMap(Map<String, dynamic> map){
    return movieModel(
      idMovie: map['idmovie'],
      validar: map['validar']
    );
  }
}