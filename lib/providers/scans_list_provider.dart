import 'package:flutter/material.dart';
import 'package:qr_reader/providers/bd_provider.dart';



class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async{

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvide.db.newScan(nuevoScan);
    // asignar el id que regresa la bd 
    nuevoScan.id = id;

    if( tipoSeleccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScan() async {
    final scan = await DBProvide.db.getTodosLosScans();
    this.scans = [...scan!];
    notifyListeners();
  }


  cargarScanPorTipo(String tipo) async{
    final scan = await DBProvide.db.getPorTipo(tipo);
    this.scans = [...scan!];
    this.tipoSeleccionado=tipo;
    notifyListeners();
  }


  borrarScans() async{
    await DBProvide.db.deleteTodosLosScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScansPorId(int id) async{
    final scan = await DBProvide.db.deleteScan(id);
  }



}