//REMEMBER THIS IS NOT WORKING BECUASE OF "BILLING PAYMENT NOT ADDED TO GOOGLE CLOUD", CODE IS ALL SAME AS SIR ASIF TAJ
//google cloud me jaa kr places api ko pehly enable krna ha


// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});
  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}
class _GooglePlacesApiState extends State<GooglePlacesApi> {
  final TextEditingController _controller =TextEditingController();
  var uuid = const Uuid();
  String _sessiontoken = '123456';
  List<dynamic> _placeslist = [];

  @override
  void initState() {
    super.initState();
    //to get notified of any changes in  textformfield
    _controller.addListener(() {
      onchanged();
    });
  }
  void onchanged(){
    if (_sessiontoken == null) {
      setState(() {
        //storing device id in _sessiontoken
        _sessiontoken = uuid.v4();
      }); 
    }
    else{
      getsugestion(_controller.text);
    }
  }
  void getsugestion(String input)async{
    String _kgoogleplacesapikey = 'AIzaSyCNmLlsITWtkL2M19EzmqFkfZewXFscbgU';
    String baseurl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseurl?input=$input&key=$_kgoogleplacesapikey&sessiontoken=$_sessiontoken';
    var response = await http.get(Uri.parse(request));
    
    if (response.statusCode == 200) {
      setState(() {
        _placeslist = jsonDecode(response.body.toString()) ['predictions'];  
      });
    }else{
      throw Exception('Failed to load data');    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Search Places Api'),
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(vertical :12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search for Places',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount : _placeslist.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: ()async{
                       List<Location> locations = await locationFromAddress(_placeslist[index]['description']);
                       print(locations.last.latitude.toString());
                       print(locations.last.longitude.toString());
                    },
                    title: Text(_placeslist[index]['description']),
                  );
                },)
              )
          ],
        ),
        ),
    );
  }
}