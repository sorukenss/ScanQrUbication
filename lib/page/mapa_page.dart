import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
   
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  
   final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
  final CameraPosition puntoInicial = CameraPosition(
    target:scan.getLatLng(),
    zoom: 17.5,
    tilt: 50,
  );

  Set<Marker> markers = new Set<Marker>();
  markers.add(new Marker(
    markerId: MarkerId('geo-location'),
    position: scan.getLatLng(),
    ));
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
          onPressed: () async{
            final GoogleMapController controller = await _controller.future;
            await controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: scan.getLatLng(),
                zoom: 17.5,
                tilt: 50,
                ),
            ));
          },
           icon: const Icon(Icons.location_on_rounded)
           ),
        ],
      ),
      body:  GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: (){
            if(mapType == MapType.normal){
              mapType= MapType.satellite;
            }else{
              mapType == MapType.normal;
            }
            setState(() {});
      },
      ),
    );
  }
}