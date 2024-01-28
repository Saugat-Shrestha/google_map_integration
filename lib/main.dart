import 'package:flutter/material.dart';
import 'package:google_map/Home_Page.dart';
import 'package:google_map/convert_latlang_to_address.dart';
import 'package:google_map/polylines.dart';

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
      home: PolyLines(),
    );
  }
}
