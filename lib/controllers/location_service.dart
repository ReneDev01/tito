import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String text) async {
  http.Response response;

  response = await http.get(
    Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&types=geocode&key=AIzaSyC9AWx_hS2Ly4fF6PQOEMM6mlcevpMSYDE"
        ),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
  );

  print(jsonDecode(response.body));
  return response;
}
