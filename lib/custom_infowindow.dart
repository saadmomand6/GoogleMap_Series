import 'package:flutter/material.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});
  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
   final List<LatLng> _latLng = <LatLng> [
    const LatLng(24.9223793,67.0794804),const LatLng(24.9323228,67.0853813),const LatLng(24.9279933,67.0932348), 
    const LatLng(24.9156333,67.0925489),const LatLng(24.9004721,67.0755502),const LatLng(24.8912858,67.0739472)
  ];

  @override
  void initState() {
    super.initState();
    loaddata();
  }
  loaddata(){
    for (var i = 0; i < _latLng.length; i++) {
      if (i%2 == 0) {
        _markers.add(
      Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng[i],
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: const  BoxDecoration(
                         image: DecorationImage(image: AssetImage('bycicle.png'),
                         fit: BoxFit.fitWidth,
                         filterQuality: FilterQuality.high
                         ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.yellow
                      ),
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10,),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 250,
                          child: Text('Not a Bykea Rider',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          ),),
                           Spacer(),
                          Text('nill')

                    ]),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                    child: Row(
                      children: const  [
                        SizedBox(
                          width: 250,
                          child: Text('Your Rider will be arrive sooner!',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          ),),
                          

                    ]),
                  )
                ],
              )
            ),
            _latLng[i],

          );
        },
    ));
      }
      else{
        _markers.add(
      Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng[i],
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: 100,
                    decoration: const  BoxDecoration(
                      image: DecorationImage(image: AssetImage('bykea.jpg'),
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 100,
                          child: Text('Bykea Rider',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          ),),
                           Spacer(),
                          Text('3 min')

                    ]),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      children: const  [
                        SizedBox(
                          width: 100,
                          child: Text('Your Rider will be arrive sooner!',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          ),),
                          

                    ]),
                  )
                ],
              )
            ),
            _latLng[i],

          );
        },
    ));
      }
    
    setState(() {
    });
  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Info Window Screen'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.9223793,67.0794804),
              zoom: 14,),
              markers: Set<Marker>.of(_markers),
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
              
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 300,
              offset: 35,
            )
        ]
        ),
    );
  }
}