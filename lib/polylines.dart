import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLines extends StatefulWidget {
  const PolyLines({super.key});

  @override
  State<PolyLines> createState() => _PolyLinesState();
}

class _PolyLinesState extends State<PolyLines> {
  Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId("_kGooglePlex"),
    infoWindow: InfoWindow(title: "My location"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(28.220504665668248, 83.9862168335855),
  );

  final Marker _kLake = Marker(
    markerId: MarkerId("_kLake"),
    infoWindow: InfoWindow(title: "Lakeside"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(28.222283077856794, 83.95192778940053),
  );

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.223215426677967, 83.98696786780411),
    zoom: 14,
  );

  final Polyline _kpolylines = Polyline(
    polylineId: PolylineId("_kpolylines"),
    points: [
      LatLng(28.220504665668248, 83.9862168335855),
      LatLng(28.222283077856794, 83.95192778940053),
    ],
    width: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: "Search by places"),
                onChanged: (value) {
                  print(value);
                },
              )),
              IconButton(
                onPressed: () async {
                  var place =
                      await LocationServices().getPlace(_searchController.text);
                  _gotoplace(place);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              polylines: {_kpolylines},
              markers: {_kGooglePlexMarker, _kLake},
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     GoogleMapController controller = await _controller.future;
      //     controller.animateCamera(
      //       CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //           target: LatLng(28.218502397090017, 83.99532336092742),
      //           zoom: 14,
      //         ),
      //       ),
      //     );
      //     setState(() {});
      //   },
      //   child: Icon(Icons.location_city_outlined),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _gotoplace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14),
      ),
    );
  }
}
