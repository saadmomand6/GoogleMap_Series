import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Convertlatlngtoaddress extends StatefulWidget {
  const Convertlatlngtoaddress({super.key});
  @override
  State<Convertlatlngtoaddress> createState() => _ConvertlatlngtoaddressState();
}

class _ConvertlatlngtoaddressState extends State<Convertlatlngtoaddress> {
  String myrecentaddress = '' , myrecentcoordinates = '';
  //static const apikey = 'AIzaSyCNmLlsITWtkL2M19EzmqFkfZewXFscbgU';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convert Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(myrecentaddress),
          Text(myrecentcoordinates),
          GestureDetector(
            onTap: ()async{
              //part 8 geocoding
              List<Location> locations = await locationFromAddress("Shahid Royal City Gulshan-e-Iqbal block 1, Karachi");
              List<Placemark> placemarks = await placemarkFromCoordinates(24.92163, 67.0825906);
              
              setState(() {
                myrecentaddress = '${locations.last.latitude.toString()}' '${locations.last.longitude.toString()}';
                myrecentcoordinates = '${placemarks.reversed.last.country.toString()}' '${placemarks.reversed.last.locality.toString()}';
              });

              //part 7  flutter_geocoder
              // final coordinates = Coordinates(24.92163, 67.0825906);
              // var address =await GeoCoder.local.findAddressesFromCoordinates(coordinates);
              // var first = address.first;
              // // ignore: avoid_print
              // print(first.featureName.toString() + first.addressLine.toString());
              // setState(() {
              //   myrecentaddress = first.adminArea.toString();
              // });
              //locationGeocoder plugin
              // late LocatitonGeocoder geocoder = LocatitonGeocoder(apikey);
              // final coordinates = Coordinates(24.92163,67.0825906);
              // final address =await geocoder.findAddressesFromCoordinates(coordinates);
              // var first = address.first;
              // // ignore: avoid_print
              // print('Address:' + first.addressLine.toString(),);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Center(child: Text('Convert'),),
              ),
            ),
          )
        ]),
    );
  }
}