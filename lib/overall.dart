import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Overall extends StatefulWidget {
  const Overall({super.key});
  @override
  State<Overall> createState() => _OverallState();
}

class _OverallState extends State<Overall> {
  String mapTheme = '';
  //controller of googlemap
  final Completer<GoogleMapController> _control = Completer();
  //final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  //starting position
  static const CameraPosition startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );
  //list for markers
  final List<Marker> _markers = <Marker>[];
   Uint8List? markerimage;
   //list for marker titles
  final List<String> markertitles = ['This is First Car','This is Shopping Mall','This is First Bike',
  'This is Second Car','This is Second Bike','This is Hospital'];
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
    DefaultAssetBundle.of(context).loadString('assets/maptheme/standard_theme.json').then((value) => {
      mapTheme = value
    });
    gettingmarkersandprovidingcoordinates();
  }
  gettingmarkersandprovidingcoordinates()async{
    //for loop to add all markers
    for (var i = 0; i < images.length; i++) {
      final Uint8List markericon = await getbytefromasset(images[i], 80);
              _markers.add(
                Marker(
                  markerId: MarkerId(i.toString()),
                  position: _latLng[i],
                  icon: BitmapDescriptor.fromBytes(markericon),
                  infoWindow:  InfoWindow(title: markertitles[i]),
              ));
              setState(() {
              });

      // if(i == 0){
      //   // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow:const  InfoWindow(title: 'This is First Car'),
      //         ));
      //         setState(() {
      //         });
      // }else if(i == 1){
      //     // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow:const  InfoWindow(title: 'This is Shopping Mall'),
      //         ));
      //         setState(() {
      //         });
      // }else if(i == 2){
      //     // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow: const  InfoWindow(title: 'This is First Bike'),
      //         ));
      //         setState(() {
      //         });
      // }else if(i == 3){
      //     // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow:const  InfoWindow(title: 'This is Second Car'),
      //         ));
      //         setState(() {
      //         });
      // }else if(i == 4){
      //     // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow:const  InfoWindow(title: 'This is Second Bike'),
      //         ));
      //         setState(() {
      //         });
      // }else {
      //     // to get images from getbytefromasset function and get the coordinates from _latlng
      // final Uint8List markericon = await getbytefromasset(images[i], 80);
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(i.toString()),
      //             position: _latLng[i],
      //             icon: BitmapDescriptor.fromBytes(markericon),
      //             infoWindow:const  InfoWindow(title: 'This is Hospital'),
      //         ));
      //         setState(() {
      //         });
      // }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter Google Map'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _control.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/darktheme.json').then((String) => {
                      value.setMapStyle(String)
                    })
                  });
                },
                child: const Text('Dark')
                ),
              PopupMenuItem(
                onTap: () {
                  _control.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/night_theme.json').then((String) => {
                      value.setMapStyle(String)
                    })
                  });
                },
                child: const Text('Night')
                ),
              PopupMenuItem(
                onTap: () {
                  _control.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/retro_theme.json').then((String) => {
                      value.setMapStyle(String)
                    })
                  });
                },
                child: const Text('Retro')
                ),
              PopupMenuItem(
                onTap: () {
                  _control.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((String) => {
                      value.setMapStyle(String)
                    })
                  });
                },
                child: const  Text('silver')
                ),
            ]
            ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
        initialCameraPosition: startposition,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        
        onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapTheme);
                _control.complete(controller);
              },
        
        )
        ),
    );
  }
}