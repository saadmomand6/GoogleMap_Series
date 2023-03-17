import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  //controller is for to locate the changes
  Completer<GoogleMapController> control = Completer();
  //for initial camera position
  static const CameraPosition _kgooglecam =  CameraPosition(
    target: LatLng(24.915673, 67.0878757),
    zoom: 14.4746,
  );
  //for markers
  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.9228386, 67.0816371),
      infoWindow: InfoWindow(
        title: 'My current location'
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.9223603, 67.0862397),
      infoWindow: InfoWindow(
        title: 'Rab Medical Center'
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.9323574, 67.0850751),
      infoWindow: InfoWindow(
        title: 'Lucky One Mall'
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kgooglecam,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller){
            control.complete(controller);
          },       
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          GoogleMapController controler = await control.future;
          controler.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
            target: LatLng(24.9228386, 67.0816371),
            zoom: 14, 
            )));
            setState(() {   
            });
        }),
    );}}