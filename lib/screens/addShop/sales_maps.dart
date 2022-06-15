import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class sales_maps extends StatefulWidget {
  const sales_maps({Key? key}) : super(key: key);

  @override
  _sales_mapsState createState() => _sales_mapsState();
}

class _sales_mapsState extends State<sales_maps> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //
  // late final addRetailerProvider addRetailerprovider;
  //
  // late final Maps mapsProvider;

  // List<Marker> _markers = <Marker>[];

  @override
  void dispose() {
    print("DISPOSE");
    super.dispose();
    mapController!.dispose();
    // _attendanceButtonController.stop();
  }

  @override
  void initState() {
    super.initState();
    // addRetailerprovider = Provider.of<addRetailerProvider>(context, listen: false);
    // mapsProvider = Provider.of<Maps>(context, listen: false);
    // mapsProvider.getCounter??mapsProvider.shopMapLocation = mapsProvider.getCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      onMapCreated: _onMapCreated,
      markers: <Marker>{
        Marker(
            markerId: MarkerId('shopmarkerId'),
            position: LatLng(31.4825735, 74.3227862),
            draggable: true,
            onDragEnd: (latlong) {
              print("log.d");
              print("onDragEnd");
              print(latlong);
              // mapsProvider.setShopMarkerPosition(latlong);
            })
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(31.4825735, 74.3227862),
        zoom: 13.0,
      ),
    ));
  }
}
