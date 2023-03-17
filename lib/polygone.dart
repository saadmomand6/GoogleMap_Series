import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});
  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  final Completer<GoogleMapController> _control = Completer();
  static const CameraPosition _startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );
  final Set<Polygon> _polygones = HashSet<Polygon>();
   List<LatLng> points = const [
    //starting point or ending point lazmi same huna chaye
    LatLng(24.911598, 67.097592),
    LatLng(24.894403, 67.070235),
    LatLng(24.896929, 67.067403),
    LatLng(24.900929, 67.073345),
    LatLng(24.906739, 67.064572),
    LatLng(24.914949, 67.078636),
    LatLng(24.927577, 67.085553),
    LatLng(24.945550, 67.087363),
    LatLng(24.947444, 67.089823),
    LatLng(24.915917, 67.118184),
    LatLng(24.910065, 67.100592),
    LatLng(24.913043, 67.098178),
    LatLng(24.911598, 67.097592),
  ];

  @override
  void initState() {
    super.initState();
    _polygones.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeColor: Colors.deepOrange,
        strokeWidth: 4,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygone Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: _startposition,
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        polygons: _polygones,
        onMapCreated: (GoogleMapController controller) {
          _control.complete(controller);
        },
        ),
      );
  }
}