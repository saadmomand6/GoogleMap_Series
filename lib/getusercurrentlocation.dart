// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});
  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _control = Completer();
  static const CameraPosition _kcamposition = CameraPosition(
    target: LatLng(24.8338316, 67.0324972),
    zoom: 14,
    );
    final List<Marker> _markers =  <Marker>[
            const Marker(
              markerId: MarkerId('1'),
              position: LatLng(24.8338316, 67.0324972),
              infoWindow: InfoWindow(
                title: 'Teen Talwaar'
              )
              )
    ];

   Future getcurrentlocation()async{
    //for permission
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) {
          print('error: $error');
    });
    //get current location by using geolocator plugin
    return await Geolocator.getCurrentPosition();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get User Current Location'),
      ),
      body: SafeArea(
        child: GoogleMap(
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: _kcamposition,
          onMapCreated: (controller) {
            _control.complete(controller);
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          ),
          
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.location_on),
            onPressed: (){
              getcurrentlocation().then((value) async{
                print('my current location');
                print('${value.latitude} ${value.longitude}');
                //to add marker on your location
                _markers.add(
                  Marker(markerId: const MarkerId('2'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'My current location'
                  )
                  )
                );
                //to move screen camera position to that location
                CameraPosition cameraPosition = CameraPosition(
                  zoom: 14,
                  target: LatLng(value.latitude, value.longitude),);
                //controller for moving the position
                final GoogleMapController controlller = await _control.future;
                controlller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {
                });
              });
            }),
    );
  }
}