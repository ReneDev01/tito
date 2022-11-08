import 'dart:convert';
import 'package:tito/controllers/client_controller.dart';
import 'package:tito/controllers/const_url.dart';
import 'package:tito/models/trip.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> makeTrip(
    String phone_number,
    String start_description,
    String end_description,
    Map start_location,
    Map end_location,
    String start_district_id,
    String start_address_id,
    String end_address_id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.post(
        Uri.parse('http://145.239.198.239:8090/api/trip_requests'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
        body: json.encode({
          'phone_number': phone_number,
          'start_description': start_description,
          'end_description': end_description,
          'start_location': start_location,
          'end_location': end_location,
          'start_district_id': start_district_id,
          'start_address_id': start_address_id,
          'end_address_id': end_address_id,
        }));
    //print(response.body);
    switch (response.statusCode) {
      case 201:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 400:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    //print(e);
    apiResponse.error = serverError;
  }

  return apiResponse;
}
