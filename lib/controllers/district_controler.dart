import 'dart:convert';

import 'package:tito/models/district.dart';
import 'package:http/http.dart' as http;

import 'client_controller.dart';

class FetchDistrictList {
  var data = [];
  List<District> results = [];

  Future<List<District>> getDistrictList({String? query}) async {
    var getDistricts = "http://145.239.198.239:8090/api/districts";
    var url = Uri.parse(getDistricts);
    try {
      String token = await getToken();
      var response = await http.get(
        url,
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},

      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => District.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.name!.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
