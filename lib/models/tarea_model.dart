import 'package:intl/intl.dart';

class TareaModelo {
  
  int? idTarea;
  String? nombreTarea;
  String? fecExpiracion;
  String? fecRecordatorio;
  String? descripcionTarea;
  int? realizada;
  int? idProfesor;

  TareaModelo({this.idTarea, this.nombreTarea, this.fecExpiracion, this.fecRecordatorio, this.descripcionTarea, this.realizada, this.idProfesor});

  factory TareaModelo.fromMap(Map<String, dynamic> map){
    return TareaModelo(
      idTarea: map['idtarea'],
      nombreTarea: map['nomtarea'],
      fecExpiracion: map['fecexpiracion'],
      fecRecordatorio: map['fecrecordatorio'],
      descripcionTarea: map['destarea'],
      realizada: map['realizada'],
      idProfesor: map['idprofesor'],
    );
  }

  DateTime get fechaExpiracion {
    final format = DateFormat('yyyy-MM-dd');
    return format.parse(fecExpiracion!);
  }
}