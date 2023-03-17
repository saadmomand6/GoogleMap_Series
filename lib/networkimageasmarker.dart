import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';
import 'dart:ui' as ui;

class NetoworkImageMarker extends StatefulWidget {
  const NetoworkImageMarker({super.key});

  @override
  State<NetoworkImageMarker> createState() => _NetoworkImageMarkerState();
}

class _NetoworkImageMarkerState extends State<NetoworkImageMarker> {
   final Completer<GoogleMapController> _control = Completer();
   static const CameraPosition _startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );  
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = [ 
    const LatLng(24.9223793,67.0794804),const LatLng(24.9323228,67.0853813),const LatLng(24.9279933,67.0932348), 
    const LatLng(24.9156333,67.0925489),const LatLng(24.9004721,67.0755502),const LatLng(24.8912858,67.0739472)
  ];
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata()async{
    for (var i = 0; i < _latlng.length; i++) {
      //image hamesha kum MB wali uthana jo size me kum hu
      Uint8List? image =await loadNetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fprofile%2F&psig=AOvVaw25WTueye93KFQncp1BFLxH&ust=1678979521495000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCJjoq6Kc3v0CFQAAAAAdAAAAABAE');
      //**all process id to get the image**
      //for image size
      final ui.Codec markerimagecodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );
      final ui.FrameInfo frameInfo = await markerimagecodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );
      final Uint8List resizedimagemarker = byteData!.buffer.asUint8List();
      //**till here**
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(resizedimagemarker),
          infoWindow: InfoWindow(
            title: 'tittle of marker: ${i.toString}'
          )
      ));
      setState(() {
      });
    }
  }

  //to convert image into ByteData
  Future<Uint8List?> loadNetworkImage(String path)async{
    final completer = Completer<ImageInfo>();
    var imagelink = NetworkImage(path);
    imagelink.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((Info,_) => completer.complete(Info))
      );
    final imgInfo  = await completer.future;
    final byteData =await imgInfo.image.toByteData(format: ui.ImageByteFormat.png); 
    return byteData?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network image as Marker'),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _startposition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _control.complete(controller);
          },
          
          )),
    );
  }
}