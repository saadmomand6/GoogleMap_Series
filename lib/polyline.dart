import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});
  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

  final Completer<GoogleMapController> _control = Completer();
  static const CameraPosition _startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline ={};
  List<LatLng> latlng = const [
    //Add some more point between starting and ending point to get a details polyline (step by step route)
    LatLng(24.9223793,67.0774419),
    LatLng(24.915673,67.0899142),
  ];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          //lastmapposition is any coordinate which should be your default position when map opens up
          position: latlng[i],
          infoWindow: const  InfoWindow(
            title: 'Current Position',
            snippet: '5 star rating'
          ),
          icon: BitmapDescriptor.defaultMarker,
      )
      );
      setState(() {
        
      });
      _polyline.add(
      Polyline(
        polylineId: const PolylineId('1'),
        points: latlng,
        color: Colors.orange
        )
        );
      
    }
    
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
        markers: _markers,
        polylines: _polyline,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _control.complete(controller);
        },
        ),
    );
  }
}