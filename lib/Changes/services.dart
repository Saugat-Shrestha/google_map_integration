import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationConverter {
  final String apiKey; // Your Google Maps Geocoding API key

  LocationConverter(this.apiKey);

  Future<Map<String, dynamic>?> getLocationCoordinates(
      String locationName) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$locationName&key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = json.decode(response.body);
      if (result['status'] == 'OK' && result['results'].isNotEmpty) {
        final location = result['results'][0]['geometry']['location'];
        return {
          'latitude': location['lat'],
          'longitude': location['lng'],
        };
      } else {
        print('Geocoding API error: ${result['status']}');
        return null;
      }
    } else {
      print(
          'Failed to get geocoding data. Status code: ${response.statusCode}');
      return null;
    }
  }
}

void main() async {
  final apiKey = 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0';
  final locationConverter = LocationConverter(apiKey);

  // Replace 'LocationName' with the actual location name you want to convert
  final locationName = 'LocationName';
  final coordinates =
      await locationConverter.getLocationCoordinates(locationName);

  if (coordinates != null) {
    print('Location: $locationName');
    print('Latitude: ${coordinates['latitude']}');
    print('Longitude: ${coordinates['longitude']}');
  } else {
    print('Failed to retrieve coordinates for $locationName');
  }
}
