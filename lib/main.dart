import 'package:flutter/material.dart';
import 'package:google_map/Changes/Last.dart';
import 'package:google_map/Changes/del.dart';
// import 'package:google_map/Home_Page.dart';
import 'package:google_map/old/convert_latlang_to_address.dart';
import 'package:google_map/old/polylines.dart';
import 'package:google_map/Changes/temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: TrackingState(),
    );
  }
}
