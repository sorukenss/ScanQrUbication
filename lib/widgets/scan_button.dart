import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF','Cancelar',false,ScanMode.QR);
        //final barcodeScanRes = 'https://fernando-herrera.com';
        //final barcodeScanRes = 'geo:11.373261,-72.252098';
        if(barcodeScanRes == '-1'){
          return;
        }

        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        final nuevoScan= await scanListProvider.nuevoScan(barcodeScanRes);

        launchUrl(context, nuevoScan);

      }
      );
  }
}