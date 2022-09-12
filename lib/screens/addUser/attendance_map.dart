import 'package:erp_aspire/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendanceMap extends StatefulWidget {
  final Set<Marker> markers;
  final List<LatLng> points;
  const AttendanceMap({Key? key, required this.markers, required this.points})
      : super(key: key);

  @override
  _AttendanceMapState createState() => _AttendanceMapState();
}

class _AttendanceMapState extends State<AttendanceMap> {
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
          polylines: {
            Polyline(
              polylineId: PolylineId(widget.markers.toString()),
              color: Colors.blueAccent,
              width: 3,
              points: widget.points
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.markers.first.position.latitude,
                widget.markers.first.position.longitude),
            zoom: 17.0,
          ),
        ),
      ),
    );
  }
}
