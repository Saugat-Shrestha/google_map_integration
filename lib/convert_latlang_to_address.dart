import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google maps"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final query = "1600 Amphiteatre Parkway, Mountain View";
              var addresses =
                  await Geocoder.local.findAddressesFromQuery(query);
              var second = addresses.first;
              print("${second.featureName} : ${second.coordinates}");

              final coordinates =
                  new Coordinates(28.218502397090017, 83.99532336092742);
              var address = await Geocoder.local
                  .findAddressesFromCoordinates(coordinates);
              var first = address.first;
              print("Address: " +
                  first.featureName.toString() +
                  first.addressLine.toString());
            },
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                height: 50,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "address",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
