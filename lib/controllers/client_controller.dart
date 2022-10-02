import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/controllers/const_url.dart';
import 'package:tito/models/api_response.dart';

import '../models/client.dart';

//rgiter client
Future<ApiResponse> createClient(
    String username, String phone_number, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
        Uri.parse('http://145.239.198.239:8090/api/signup-client'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'username': username,
          'phone_number': phone_number,
          'password': password,
        });

    print(response.body);

    switch (response.statusCode) {
      case 200:
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
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<int> getClientId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getInt('clientId') ?? 0;
}

Future<ApiResponse> validatePhone(
    String request_code, String verification_code) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse("http://145.239.198.239:8090/api/verify-phone"),
      headers: {'Accept': 'application/json'},
      body: {
        'request_code': request_code,
        'verification_code': verification_code
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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
    //print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> infosCompleteClient(
    String full_name, String whatsapp_number) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    print(token);
    final response = await http.post(
      Uri.parse("http://145.239.198.239:8090/api/update-client"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'full_name': full_name, 'whatsapp_number': whatsapp_number},
    );

    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> login(String phone_number, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse("http://145.239.198.239:8090/api/signin-client"),
      headers: {
        'Accept': 'application/json',
      },
      body: {'phone_number': phone_number, 'password': password},
    );

    //switch response code status
    //print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> getClientDetails() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse("http://145.239.198.239:8090/api/user"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    print(response.body);

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

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString('token') ?? '';
}

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return await pref.remove('token');
}
