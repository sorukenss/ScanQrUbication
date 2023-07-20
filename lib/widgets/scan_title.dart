import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/scans_list_provider.dart';

class ScanTitle extends StatelessWidget {
  final String tipo;

  const ScanTitle({required this.tipo});

  @override
  Widget build(BuildContext context) {
     final scanListProvider =Provider.of<ScanListProvider>(context);
    final scans= scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: const Color.fromARGB(255, 238, 67, 93),
        ),
        onDismissed: (DismissDirection dismissDirection){
          Provider.of<ScanListProvider>(context,listen: false).borrarScansPorId(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'geo'
            ?Icons.location_on
            :Icons.home_outlined,
            color: Theme.of(context).primaryColor
            ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.teal[200],),
          onTap: () => launchUrl(context,scans[i])
        ),
      ),
    
    );
  }
}