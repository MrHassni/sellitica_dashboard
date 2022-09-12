import 'package:erp_aspire/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocationMap extends StatefulWidget {
  final Set<Marker> markers;
  const LiveLocationMap({Key? key, required this.markers}) : super(key: key);

  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 3)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GoogleMap(
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          onMapCreated: _onMapCreated,
          markers: widget.markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.markers.first.position.latitude,
                widget.markers.first.position.longitude),
            zoom: 13.0,
          ),
        ),
      ),
    );
  }
}
