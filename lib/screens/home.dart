import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MyHomepage extends StatefulWidget {
  static const String idScreen = "homepage";
  MyHomepage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
          {
             _controllerGoogleMap.complete(controller);
             newGoogleMapController =controller;
             }
          ),
        ],
        ),

    );
  }
}
