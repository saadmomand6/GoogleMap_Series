import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoosgleMap extends StatefulWidget {
  const StyleGoosgleMap({super.key});

  @override
  State<StyleGoosgleMap> createState() => _StyleGoosgleMapState();
}

class _StyleGoosgleMapState extends State<StyleGoosgleMap> {
  String mapTheme = '';
   final Completer<GoogleMapController> _control = Completer();
   static const CameraPosition _startposition = CameraPosition(
    target: LatLng(24.9223793,67.0794804),
    zoom: 14,
  );  
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/maptheme/darktheme.json').then((value) => {
      mapTheme = value
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style of google Map'),
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
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _startposition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
            _control.complete(controller);
          },
      ),
    );
  }
}