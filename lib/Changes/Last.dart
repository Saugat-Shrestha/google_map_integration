// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrackingState extends StatefulWidget {
//   const TrackingState({super.key});

//   @override
//   State<TrackingState> createState() => _TrackingStateState();
// }

// const LatLng dest_location = LatLng(37.42796133580664, -122.085749655962);

// class _TrackingStateState extends State<TrackingState> {
//   late GoogleMapController mapController;

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

//   late Position currentPosition;
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
//       home: Scaffold(
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
//       "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0",
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
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingState extends StatefulWidget {
  const TrackingState({super.key});

  @override
  State<TrackingState> createState() => _TrackingStateState();
}

const LatLng dest_location = LatLng(37.42796133580664, -122.085749655962);

class _TrackingStateState extends State<TrackingState> {
  late GoogleMapController mapController;

  // Markers to show points on the map
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late Position currentPosition;
  var geoLocator = Geolocator();

  void getCurrentPosition() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = _kGooglePlex;
    if (currentPosition != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14.4746,
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          padding: EdgeInsets.only(top: 135),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            mapController = controller;
            _getPolyline();
          },
          polylines: Set<Polyline>.of(polylines.values),
          markers: Set<Marker>.of(markers.values),
        ),
      ),
    );
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    // add origin marker
    _addMarker(
      LatLng(currentPosition.latitude, currentPosition.longitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // add destination marker
    _addMarker(
      LatLng(dest_location.latitude, dest_location.longitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0",
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(dest_location.latitude, dest_location.longitude),
      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
