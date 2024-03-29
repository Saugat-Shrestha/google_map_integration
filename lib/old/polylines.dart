// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_map/location_service.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PolyLines extends StatefulWidget {
//   const PolyLines({super.key});

//   @override
//   State<PolyLines> createState() => _PolyLinesState();
// }

// class _PolyLinesState extends State<PolyLines> {
//   Completer<GoogleMapController> _controller = Completer();
//   final TextEditingController _searchController = TextEditingController();

//   final Marker _kGooglePlexMarker = Marker(
//     markerId: MarkerId("_kGooglePlex"),
//     infoWindow: InfoWindow(title: "My location"),
//     icon: BitmapDescriptor.defaultMarker,
//     position: LatLng(28.220504665668248, 83.9862168335855),
//   );

//   final Marker _kLake = Marker(
//     markerId: MarkerId("_kLake"),
//     infoWindow: InfoWindow(title: "Lakeside"),
//     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//     position: LatLng(28.222283077856794, 83.95192778940053),
//   );

//   final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(28.223215426677967, 83.98696786780411),
//     zoom: 14,
//   );

//   final Polyline _kpolylines = Polyline(
//     polylineId: PolylineId("_kpolylines"),
//     points: [
//       LatLng(28.220504665668248, 83.9862168335855),
//       LatLng(28.222283077856794, 83.95192778940053),
//     ],
//     width: 5,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: TextFormField(
//                 controller: _searchController,
//                 textCapitalization: TextCapitalization.words,
//                 decoration: InputDecoration(hintText: "Search by places"),
//                 onChanged: (value) {
//                   print(value);
//                 },
//               )),
//               IconButton(
//                 onPressed: () async {
//                   var place =
//                       await LocationServices().getPlace(_searchController.text);
//                   _gotoplace(place);
//                 },
//                 icon: Icon(Icons.search),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GoogleMap(
//               polylines: {_kpolylines},
//               markers: {_kGooglePlexMarker, _kLake},
//               myLocationEnabled: true,
//               compassEnabled: true,
//               myLocationButtonEnabled: true,
//               mapType: MapType.normal,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           ),
//         ],
//       )),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     GoogleMapController controller = await _controller.future;
//       //     controller.animateCamera(
//       //       CameraUpdate.newCameraPosition(
//       //         CameraPosition(
//       //           target: LatLng(28.218502397090017, 83.99532336092742),
//       //           zoom: 14,
//       //         ),
//       //       ),
//       //     );
//       //     setState(() {});
//       //   },
//       //   child: Icon(Icons.location_city_outlined),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//     );
//   }

//   Future<void> _gotoplace(Map<String, dynamic> place) async {
//     final double lat = place['geometry']['location']['lat'];
//     final double lng = place['geometry']['location']['lng'];

//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(lat, lng), zoom: 14),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_google_maps/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map/old/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(PolyLines());

class PolyLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.220504665668248, 83.9862168335855),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(28.220504665668248, 83.9862168335855));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
      
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: InputDecoration(hintText: ' Origin'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration: InputDecoration(hintText: ' Destination'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections(
                    _originController.text,
                    _destinationController.text,
                  );
                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(directions['polyline_decoded']);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }
}
