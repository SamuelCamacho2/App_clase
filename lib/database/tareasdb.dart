import 'dart:async';
import 'dart:io';
import 'package:my_app/models/carrera_model.dart';
import 'package:my_app/models/profesor_model.dart';
import 'package:my_app/models/tarea_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TareaDB {
  static const nameDB = 'TAREASBD';
  static const versionBD = 1;

  static Database? _database;

  Future<Database?>get database async{
    if(_database != null) return _database!;
    return _database = await _initDatabases();
  }

  Future<Database?> _initDatabases() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nameDB);

    return openDatabase(
      pathBD,
      version: versionBD.bitLength,
      onCreate: _createtable
    );
  }

  FutureOr<void> _createtable(Database db, int version) {

    String queryCarrera = '''CREATE TABLE tblCarrera(
        idcarrera INTEGER PRIMARY KEY, 
        nomcarrera VARCHAR(50)
        );''';
      db.execute(queryCarrera);


    String queryPorfesor = '''CREATE TABLE tblProfesor(
        idprofesor INTEGER PRIMARY KEY, 
        nomprofe VARCHAR(50), 
        idcarrera INTEGER(50), 
        email VARCHAR(50),
        FOREIGN KEY (idcarrera) REFERENCES tblCarrera(idcarrera)
        );''';
      db.execute(queryPorfesor);

    String queryTarea = '''CREATE TABLE tblTareas(
        idtarea INTEGER PRIMARY KEY, 
        nomtarea VARCHAR(50), 
        fecexpiracion STRING, 
        fecrecordatorio STRING,
        destarea TEXT,
        realizada INTEGER,
        idprofesor INTEGER,
        FOREIGN KEY (idprofesor) REFERENCES tblProfesor(idprofesor)
        );''';
      db.execute(queryTarea);
  }

  // ignore: non_constant_identifier_names
  Future<int> INSERT(String tblName, Map<String, dynamic> data) async{
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  // ignore: non_constant_identifier_names
  Future<int> UPDATE(String tblName, Map<String, dynamic> data,String id, int campo) async{
    var conexion = await database;
    return conexion!.update(tblName, data, where: '$id = ?', whereArgs: [campo]);
  }

  // ignore: non_constant_identifier_names
  Future<int> Delete(String tblName, int idtarea, String id ) async{
    var conexion = await database;
    return conexion!.delete(tblName, where: '$id = ?', whereArgs: [idtarea]);
  } 

  // ignore: non_constant_identifier_names
  Future<List<CarreraModel>> ListarCarrera() async{
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((task)=>CarreraModel.fromMap(task)).toList();
  }

  Future<List<ProfesorModel>> ListarProfesor() async{
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((task)=>ProfesorModel.fromMap(task)).toList();
  }

  Future<List<TareaModelo>> ListarTareas() async{
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task)=>TareaModelo.fromMap(task)).toList();
  }

  Future<String> nombreCarrera(int id) async{
    var conexion = await database;
    var result = await conexion!.query('tblCarrera', where: 'idcarrera = ?', whereArgs: [id]);
    if(result.isNotEmpty){
      return result.first['nomcarrera'].toString();
    }else{
      return 'No hay carrera';
    }
  }

  Future<String> nombreProfe(int id) async{
    var conexion = await database;
    var result = await conexion!.query('tblProfesor', where: 'idprofesor = ?', whereArgs: [id]);
    if(result.isNotEmpty){
      return result.first['nomprofe'].toString();
    }else{
      return 'No hay profesor';
    }
  }

  Future<int> UpdateTare( String tbl, Map<String, dynamic> data, int id) async{
    var conexion = await database;
    return conexion!.update(tbl, data, where: 'idtarea = ?', whereArgs: [data[id]]);    
  }

  Future<List<TareaModelo>> ListarTareasPendientes() async{
  var conexion = await database;
  var result = await conexion!.query('tblTareas', where: 'realizada = ?', whereArgs: [0]);
  return result.map((task)=>TareaModelo.fromMap(task)).toList();
}

Future<List<TareaModelo>> ListarTareasRealizadas() async{
  var conexion = await database;
  var result = await conexion!.query('tblTareas', where: 'realizada = ?', whereArgs: [1]);
  return result.map((task)=>TareaModelo.fromMap(task)).toList();
}

}