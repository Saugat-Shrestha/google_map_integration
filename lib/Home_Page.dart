// ignore_for_file: prefer_const_constructors

import 'dart:async';
// import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.223215426677967, 83.98696786780411),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.223215426677967, 83.98696786780411),
      infoWindow: InfoWindow(title: "Location 1"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(28.220504665668248, 83.9862168335855),
      infoWindow: InfoWindow(title: "Location 2"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(28.218502397090017, 83.99532336092742),
      infoWindow: InfoWindow(title: "Location 2"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.satellite,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(28.218502397090017, 83.99532336092742),
                zoom: 30,
              ),
            ),
          );
          setState(() {});
        },
        child: Icon(Icons.location_city_outlined),
      ),
    );
  }
}
