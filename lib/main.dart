import 'package:flutter/material.dart';
//import 'package:googlemap/google_places_api.dart';
//import 'package:googlemap/custom_marker.dart';
//import 'package:googlemap/custom_infowindow.dart';
//import 'package:googlemap/polygone.dart';
//import 'package:googlemap/style_googlemap.dart';
import 'package:googlemap/overall.dart';
//import 'package:googlemap/polyline.dart';
//import 'package:googlemap/convert_latlng_to_address.dart';
//import 'package:googlemap/getusercurrentlocation.dart';
//import 'package:googlemap/homescreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: StyleGoosgleMap(),
      home: Overall(),
      //home: PolylineScreen(),
      //home: CustomMarkerInfoWindow(),
      //home: CustomMarker(),
      //home: GooglePlacesApi(),
      //home: GetUserCurrentLocation(),
      //home:  Convertlatlngtoaddress(),
      //home: HomeScreen(),
    );
  }
}