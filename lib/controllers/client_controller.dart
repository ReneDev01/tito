import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/controllers/const_url.dart';
import 'package:tito/models/api_response.dart';

import '../models/Client.dart';

Future<ApiResponse> createClient(String username, String phone_number, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(clientSignUp), 
      headers: {
        'accept': 'application/json'
      } , 
      body: {
        'username': username,
        'phone_number': phone_number,
        'password': password,
      });
    
    switch (response.statusCode) {
      case 200:
        apiResponse.data = Client.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString('token') ?? '';
}

Future<int> getClientId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getInt('clientId') ?? 0;
}