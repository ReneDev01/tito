import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/controllers/const_url.dart';

import '../models/api_response.dart';
import '../models/client.dart';

Future<ApiResponse> login(String phone_number) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse("http://145.239.198.239:8090/api/signin-client"),
      headers: {'Accept': 'application/json'},
      body: {'phone_number': phone_number},
    );

    //switch response code status
    //print(response.body);
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
    print(e);
  }

  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString('token') ?? '';
}

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return await pref.remove('token');
}
