import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';



class DBProvide {

  Database? _database;
  static final DBProvide db = DBProvide._();
  static const _databaseName = "ScansDB.db";
  static const _databaseVersion = 1;
  DBProvide._();

  Future<Database?> get database async {
    if(_database != null) return _database!;

    _database = await initDB();

    return _database!;

  }

Future<Database?> initDB() async{
  //donde almacenamos la bd, path
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    print(path);

  return await openDatabase(
    path,
    version: _databaseVersion,
    onOpen: (db){ },
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    }
    );
  
}

Future<int> newScanRow (ScanModel newScan) async{

  final id = newScan.id;
  final tipo = newScan.tipo;
  final valor = newScan.valor;

//verificar la bd
final db = await database;

  final res = await db!.rawInsert('''
      INSERT INTO Scans(id,tipo,valor)
      VALUES ($id,'$tipo','$valor')
''');

    return res;
}

  Future<int> newScan(ScanModel newScan) async{
    final db = await database;
    final res = await db!.insert('Scans', newScan.toJson());
    return res;
   }

   Future getScanById(int id ) async{
    final db = await database;
    final res = await db!.query('Scans', where: 'id=?', whereArgs: [id]);

    return res.isNotEmpty
              ?ScanModel.fromJson(res.first)
              :null;

   }

   Future<List<ScanModel>?> getTodosLosScans() async{
    final db = await database;
    final res = await db!.query('Scans');

    return res.isNotEmpty
              ?res.map((e) => ScanModel.fromJson(e)).toList()
              :[];

   }

   Future<List<ScanModel>?> getPorTipo(String tipo) async{
    final db = await database;
    final res = await db!.rawQuery('''
        SELECT * FROM Scans WHERE tipo = '$tipo'
      ''');
      return res.isNotEmpty
              ?res.map((e) => ScanModel.fromJson(e)).toList()
              :[];
   }

   Future<int> updateScan(ScanModel newScan) async{
    final db = await database;
    final res = await db!.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
    return res;
   }

   Future<int>  deleteScan(int id) async{
    final db = await database;
    final res = await db!.delete('Scans',where: 'id=?',whereArgs: [id]);
    return res;
   }

    Future<int>  deleteTodosLosScan() async{
    final db = await database;
    final res = await db!.delete('Scans');
    return res;
   }


}
