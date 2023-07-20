
import 'package:flutter/material.dart';
import 'package:qr_reader/page/direccion_page.dart';
import 'package:qr_reader/page/pages.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/bd_provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/widgets.dart';


class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: (){
               Provider.of<ScanListProvider>(context, listen: false).borrarScans();
            },
            icon: const Icon(Icons.delete_forever_outlined),
            ),
        ],
      ),
      body: _HomePageBody(),
      
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final currenIndex= uiProvider.selectedMenuOpt;

    final tempScan = new ScanModel( valor: 'http//google.com');
   // DBProvide.db.newScan(tempScan);
   //DBProvide.db.getScanById(5).then((scan) => print(scan.valor));
   // DBProvide.db.deleteTodosLosScan().then(print);

   // USAR EL PROVIDER 
   final scanListProvider = Provider.of<ScanListProvider>(context, listen :false);
    switch(currenIndex){
      case 0:
          scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();
      
      case 1: 
          scanListProvider.cargarScanPorTipo('http');
        return DireccionPage();

      default: 
        return MapasPage();
    }
  }
}