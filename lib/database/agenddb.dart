import 'dart:async';
import 'dart:io';

import 'package:my_app/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {
  static const nameDB = 'AGENDABD';
  static const versionBD = 1;

  static Database? _database;

  Future<Database?>get database async {
    if(_database != null) return _database!;
    return _database = await _initDatabases();
  }
  
  Future<Database?> _initDatabases() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nameDB);

    return openDatabase(
      pathBD,
      version: versionBD.bitLength,
      onCreate: _createtable
    );
  }
 
  FutureOr<void> _createtable(Database db, int version) {
    String query = '''CREATE TABLE tblTareas(
        idtask INTEGER PRIMARY KEY, 
        nametask VARCHAR(50), 
        dscTask VARCHAR(50), 
        sttTask BYTE
        );''';
      db.execute(query);
  }
  
  // ignore: non_constant_identifier_names
  Future<int> INSERT(String tblName, Map<String, dynamic> data) async{
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }
  // ignore: non_constant_identifier_names
  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async{
    var conexion = await database;
    return conexion!.update(tblName, data, where: 'idTask = ?', whereArgs: [data['idTask']]);
  }
  // ignore: non_constant_identifier_names
  Future<int> Delete(String tblName, int idtask) async{
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idtask]);
  }

  // ignore: non_constant_identifier_names
  Future<List<TaskMolde>> GETALLTASK() async{
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task)=>TaskMolde.fromMap(task)).toList();
  }

}