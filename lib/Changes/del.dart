// // import 'package:flutter/material.dart';
// // import 'dart:async';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_map/old/location_service.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class CombinedPolyLines extends StatefulWidget {
// //   const CombinedPolyLines({Key? key}) : super(key: key);

// //   @override
// //   State<CombinedPolyLines> createState() => _CombinedPolyLinesState();
// // }

// // class _CombinedPolyLinesState extends State<CombinedPolyLines> {
// //   Completer<GoogleMapController> _controller = Completer();
// //   TextEditingController _originController = TextEditingController();
// //   TextEditingController _destinationController = TextEditingController();

// //   Set<Marker> _markers = Set<Marker>();
// //   Set<Polygon> _polygons = Set<Polygon>();
// //   Set<Polyline> _polylines = Set<Polyline>();
// //   List<LatLng> polygonLatLngs = <LatLng>[];

// //   int _polygonIdCounter = 1;
// //   int _polylineIdCounter = 1;

// //   static final CameraPosition _kGooglePlex = CameraPosition(
// //     target: LatLng(28.220504665668248, 83.9862168335855),
// //     zoom: 14.4746,
// //   );

// //   @override
// //   void initState() {
// //     super.initState();
// //     _setMarker(LatLng(28.220504665668248, 83.9862168335855));
// //   }

// //   void _setMarker(LatLng point) {
// //     setState(() {
// //       _markers.add(
// //         Marker(
// //           markerId: MarkerId('marker'),
// //           position: point,
// //         ),
// //       );
// //     });
// //   }

// //   void _setPolygon() {
// //     final String polygonIdVal = 'polygon_$_polygonIdCounter';
// //     _polygonIdCounter++;

// //     _polygons.add(
// //       Polygon(
// //         polygonId: PolygonId(polygonIdVal),
// //         points: polygonLatLngs,
// //         strokeWidth: 2,
// //         fillColor: Colors.transparent,
// //       ),
// //     );
// //   }

// //   void _setPolyline(List<PointLatLng> points) {
// //     final String polylineIdVal = 'polyline_$_polylineIdCounter';
// //     _polylineIdCounter++;

// //     _polylines.add(
// //       Polyline(
// //         polylineId: PolylineId(polylineIdVal),
// //         width: 2,
// //         color: Colors.blue,
// //         points: points
// //             .map(
// //               (point) => LatLng(point.latitude, point.longitude),
// //             )
// //             .toList(),
// //       ),
// //     );
// //   }

// //   Future<void> _goToPlace(
// //     double lat,
// //     double lng,
// //     Map<String, dynamic> boundsNe,
// //     Map<String, dynamic> boundsSw,
// //   ) async {
// //     final GoogleMapController controller = await _controller.future;
// //     controller.animateCamera(
// //       CameraUpdate.newCameraPosition(
// //         CameraPosition(target: LatLng(lat, lng), zoom: 12),
// //       ),
// //     );

// //     controller.animateCamera(
// //       CameraUpdate.newLatLngBounds(
// //         LatLngBounds(
// //           southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
// //           northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
// //         ),
// //         25,
// //       ),
// //     );
// //     _setMarker(LatLng(lat, lng));
// //   }

// //   void addMarker(LatLng latLng, newSetState) {
// //     _markers.add(
// //       Marker(
// //         markerId: MarkerId(latLng.toString()),
// //         position: latLng,
// //         onTap: () {
// //           _markers.removeWhere(
// //             (element) => element.markerId == MarkerId(latLng.toString()),
// //           );
// //           if (_markers.length > 1) {
// //             getDirections(_markers, newSetState);
// //           } else {
// //             _polylines.clear();
// //           }
// //           newSetState(() {});
// //         },
// //       ),
// //     );
// //     if (_markers.length > 1) {
// //       getDirections(_markers, newSetState);
// //     }

// //     newSetState(() {});
// //   }

// //   void getDirections(Set<Marker> markers, newSetState) async {
// //     List<LatLng> polylineCoordinates = [];
// //     List<PolylineWayPoint> polylineWayPoints = [];
// //     for (var i = 0; i < markers.length; i++) {
// //       polylineWayPoints.add(
// //         PolylineWayPoint(
// //           location:
// //               "${markers.elementAt(i).position.latitude.toString()},${markers.elementAt(i).position.longitude.toString()}",
// //           stopOver: true,
// //         ),
// //       );
// //     }
// //     PolylineResult result = await LocationServices().getDirections(
// //       _originController.text,
// //       _destinationController.text,
// //       wayPoints: polylineWayPoints,
// //     );

// //     if (result.points.isNotEmpty) {
// //       result.points.forEach((PointLatLng point) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       });
// //     } else {
// //       print(result.errorMessage);
// //     }

// //     newSetState(() {});
// //     addPolyLine(polylineCoordinates, newSetState);
// //   }

// //   void addPolyLine(List<LatLng> polylineCoordinates, newSetState) {
// //     PolylineId id = PolylineId("poly");
// //     Polyline polyline = Polyline(
// //       polylineId: id,
// //       color: Colors.blue,
// //       points: polylineCoordinates,
// //       width: 4,
// //     );
// //     _polylines.add(polyline);

// //     newSetState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: Column(
// //                   children: [
// //                     TextFormField(
// //                       controller: _originController,
// //                       decoration: InputDecoration(hintText: ' Origin'),
// //                       onChanged: (value) {
// //                         print(value);
// //                       },
// //                     ),
// //                     TextFormField(
// //                       controller: _destinationController,
// //                       decoration: InputDecoration(hintText: ' Destination'),
// //                       onChanged: (value) {
// //                         print(value);
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               IconButton(
// //                 onPressed: () async {
// //                   var directions = await LocationService().getDirections(
// //                     _originController.text,
// //                     _destinationController.text,
// //                   );
// //                   _goToPlace(
// //                     directions['start_location']['lat'],
// //                     directions['start_location']['lng'],
// //                     directions['bounds_ne'],
// //                     directions['bounds_sw'],
// //                   );

// //                   addMarker(
// //                     LatLng(
// //                       directions['start_location']['lat'],
// //                       directions['start_location']['lng'],
// //                     ),
// //                     () {},
// //                   );

// //                   addMarker(
// //                     LatLng(
// //                       directions['end_location']['lat'],
// //                       directions['end_location']['lng'],
// //                     ),
// //                     () {},
// //                   );
// //                 },
// //                 icon: Icon(Icons.search),
// //               ),
// //             ],
// //           ),
// //           Expanded(
// //             child: GoogleMap(
// //               mapType: MapType.normal,
// //               markers: _markers,
// //               polygons: _polygons,
// //               polylines: _polylines,
// //               initialCameraPosition: _kGooglePlex,
// //               onMapCreated: (GoogleMapController controller) {
// //                 _controller.complete(controller);
// //               },
// //               onTap: (point) {
// //                 setState(() {
// //                   polygonLatLngs.add(point);
// //                   _setPolygon();
// //                 });
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: CombinedPolyLines(),
// //   ));
// // }



// import 'package:flutter/material.dart';

// class Temp extends StatefulWidget {
//   const Temp({super.key});

//   @override
//   State<Temp> createState() => _TempState();
// }

// class _TempState extends State<Temp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//           padding: EdgeInsets.only(top: 135),
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//           mapType: MapType.normal,
//           initialCameraPosition: initialCameraPosition,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//             mapController = controller;
//             _getPolyline();
//           },
//           polylines: Set<Polyline>.of(polylines.values),
//           markers: Set<Marker>.of(markers.values),
//         ),
//       ),
//     );
//   }

//   // This method will add markers to the map based on the LatLng position
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }

//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   void _getPolyline() async {
//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(currentPosition.latitude, currentPosition.longitude),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );

//     // Add destination marker
//     _addMarker(
//       LatLng(dest_location.latitude, dest_location.longitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );

//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "API KEY",
//       PointLatLng(currentPosition.latitude, currentPosition.longitude),
//       PointLatLng(dest_location.latitude, dest_location.longitude),
//       travelMode: TravelMode.walking,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     _addPolyLine(polylineCoordinates);
//   },
//   }




// class _TrackingState extends State<Tracking> {
//   GoogleMapController mapController;

//   // Markers to show points on the map
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];

//   PolylinePoints polylinePoints = PolylinePoints();

//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   Position currentPosition;
//   var geoLocator = Geolocator();
//   var locationOptions = LocationOptions(
//       accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

//   void getCurrentPosition() async {
//     currentPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.bestForNavigation);
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialCameraPosition = _kGooglePlex;
//     if (currentPosition != null) {
//       initialCameraPosition = CameraPosition(
//           target: LatLng(currentPosition.latitude, currentPosition.longitude),
//           zoom: 14.4746);
//     }
//     return MaterialApp(
//       home: 
// }
