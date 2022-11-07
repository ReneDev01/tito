import 'dart:convert';

import 'package:tito/controllers/client_controller.dart';
import 'package:tito/controllers/const_url.dart';

import '../models/api_response.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getStrictInfo(int placeId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse("http://145.239.198.239:8090/api/districts/+$placeId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}
