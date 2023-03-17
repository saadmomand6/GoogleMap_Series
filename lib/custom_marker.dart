import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});
  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  //controller of googlemap
  final Completer<GoogleMapController> _controling = Completer();
  //starting position
  static const CameraPosition startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );
  //list for markers
  final List<Marker> _markers = <Marker>[];
   Uint8List? markerimage;
  //list of all image paths (to store paths of images)
  final List<String> images = ['assets/car.png','assets/shopping-mall.png','assets/bycicle.png','assets/car2.png',  'assets/motorcycle.png','assets/hospital.png'];
  //images ki tadaad or latlng ki tadaad same hu
  //list of all coordinates
  final List<LatLng> _latLng = <LatLng> [
    const LatLng(24.9223793,67.0794804),const LatLng(24.9323228,67.0853813),const LatLng(24.9279933,67.0932348), 
    const LatLng(24.9156333,67.0925489),const LatLng(24.9004721,67.0755502),const LatLng(24.8912858,67.0739472)
  ];
  //to provide/get the images of markers
  Future<Uint8List> getbytefromasset(String path, int width)async{
    //to load path
    ByteData data =await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List() , targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    gettingmarkersandprovidingcoordinates();
  }
  gettingmarkersandprovidingcoordinates()async{
    //for loop to add all markers
    for (var i = 0; i < images.length; i++) {
      // to get images from getbytefromasset function and get the coordinates from _latlng
      final Uint8List markericon = await getbytefromasset(images[i], 100);
              _markers.add(
                Marker(
                  markerId: MarkerId(i.toString()),
                  position: _latLng[i],
                  icon: BitmapDescriptor.fromBytes(markericon),
                  infoWindow: InfoWindow(title: 'this is title number: ${i.toString()}'),
              ));
              setState(() {
              });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Markers'),
      ),
      body: SafeArea(child: GoogleMap(
        initialCameraPosition: startposition,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: ((controller) {
          _controling.complete(controller);
        }),
        )),
    );
  }
}